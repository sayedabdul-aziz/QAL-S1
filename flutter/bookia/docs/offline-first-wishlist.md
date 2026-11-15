# Offline-First Wishlist — Design & Implementation

## Overview

The wishlist feature uses an **optimistic update with rollback** strategy to give the user an instant, responsive experience regardless of network conditions. The heart-icon toggle reacts immediately; the network call happens silently in the background.

---

## Tech Stack

| Concern | Choice |
|---|---|
| State management | `flutter_bloc` (Cubit) |
| Local cache | `shared_preferences` — stores only the list of wishlisted product IDs (`List<int>`) |
| Networking | `Dio` |
| Connectivity check | None — failures are inferred from `null` API responses |

---

## Architecture

```
Presentation
├── WishlistScreen                  — full wishlist page (fetch + display)
│   ├── WishlistCubit               — fetches the list from the API
│   └── WishlistBooks               — renders loading / empty / grid states
│
└── WishlistAction / WishlistSmallAction  — reusable heart-icon toggle
    └── WishlistActionCubit         — drives the offline-first add/remove flow

Data
└── WishlistRepo (static class)     — calls the REST API; syncs cache on success

Core
└── SharedPref                      — thin static wrapper around shared_preferences
```

---

## Local Cache

**File:** `lib/core/services/local/shared_pref.dart`

```dart
static const String kWishlist = 'wishlist';

// shared_preferences only supports List<String>, so IDs are stored as strings
static void setWishlist(List<int> wishlistIds) {
  List<String> ids = wishlistIds.map((id) => id.toString()).toList();
  prefs.setStringList(kWishlist, ids);
}

static List<int> getWishlist() {
  var ids = prefs.getStringList(kWishlist);
  if (ids == null) return [];
  return ids.map((e) => int.tryParse(e) ?? 0).toList();
}
```

> **Important:** only the product **IDs** are cached, not the full `Product` objects. This means the heart-icon state works offline, but the full wishlist screen (titles, covers, prices) requires a successful API call.

---

## The Optimistic Update Pattern

The core of the offline-first approach lives in `WishlistActionCubit`.

**File:** `lib/features/wishlist/presentation/wishlist_action/cubit/wishlist_action_cubit.dart`

### Flow

```
User taps heart
       │
       ▼
checkIfProductInWishlist()   ← reads SharedPreferences (sync, instant)
       │
  ┌────┴────┐
  │ in list │                     │ not in list │
  ▼                               ▼
offlineRemoving()              offlineAdding()
  → remove ID from cache         → add ID to cache
  → emit WishlistActionSuccess   → emit WishlistActionSuccess
  → UI updates instantly         → UI updates instantly
       │                               │
       ▼                               ▼
WishlistRepo.removeFromWishlist()  WishlistRepo.addToWishlist()
       │                               │
  ┌────┴────┐                     ┌────┴────┐
  │ success │    failure           │ success │    failure
  ▼                  ▼            ▼                  ▼
cache re-synced   offlineAdding() cache re-synced   offlineRemoving()
from API response (rollback)      from API response (rollback)
```

### Code

```dart
Future<void> addOrRemoveFromWishlist(int productId) async {
  bool isInWishlist = checkIfProductInWishlist(productId);

  if (isInWishlist) {
    offlineRemoving(productId);                              // 1. instant UI update
    var data = await WishlistRepo.removeFromWishlist(productId);
    if (data != null) {
      emit(WishlistActionSuccess());
    } else {
      offlineAdding(productId);                             // rollback on failure
      emit(WishlistActionError());
    }
  } else {
    offlineAdding(productId);                               // 1. instant UI update
    var data = await WishlistRepo.addToWishlist(productId);
    if (data != null) {
      emit(WishlistActionSuccess());
    } else {
      offlineRemoving(productId);                          // rollback on failure
      emit(WishlistActionError());
    }
  }
}

void offlineAdding(int productId) {
  List<int> wishlistIds = SharedPref.getWishlist();
  wishlistIds.add(productId);
  SharedPref.setWishlist(wishlistIds);
  emit(WishlistActionSuccess());
}

void offlineRemoving(int productId) {
  List<int> wishlistIds = SharedPref.getWishlist();
  wishlistIds.remove(productId);
  SharedPref.setWishlist(wishlistIds);
  emit(WishlistActionSuccess());
}

bool checkIfProductInWishlist(int productId) {
  List<int> wishlistIds = SharedPref.getWishlist();
  return wishlistIds.contains(productId);
}
```

---

## Cache Sync on API Success

**File:** `lib/features/wishlist/data/repo/wishlist_repo.dart`

Every time a successful API response is received, `_mapWishlistResponse` overwrites the local cache with the server's current list. This keeps local state in sync after the app comes back online.

```dart
static WishlistResponse _mapWishlistResponse(Response<dynamic> response) {
  var wishlistResponse = WishlistResponse.fromJson(response.data);
  List<Product> products = wishlistResponse.data!.data ?? [];
  List<int> ids = products.map((e) => e.id ?? 0).toList();
  SharedPref.setWishlist(ids);    // server is source of truth on success
  return wishlistResponse;
}
```

This is called by all three repo methods: `getWishlist`, `addToWishlist`, `removeFromWishlist`.

---

## UI: How States Are Rendered

### WishlistBooks (full list screen)

**File:** `lib/features/wishlist/presentation/wishlist/widgets/wishlist_books.dart`

| Cubit State | UI |
|---|---|
| `WishlistLoadingState` | `ShimmerGridView` — 4 placeholder cards |
| `WishlistErrorState` | `ShimmerGridView` — same shimmer (no error message shown) |
| `WishlistSuccessState` + empty list | Centered icon + "Your wishlist is empty" |
| `WishlistSuccessState` + products | 2-column `GridView.builder` with `BookCard` |

An `onItemRemoved` callback on `BookCard` calls `books.removeWhere(...)` + `setState()` immediately — another layer of optimistic local UI removal before the network confirms.

### WishlistAction (heart toggle, used everywhere)

**File:** `lib/features/wishlist/presentation/wishlist_action/widgets/wishlist_action.dart`

- Each instance creates its **own** `BlocProvider<WishlistActionCubit>`.
- On every build, it calls `checkIfProductInWishlist(productId)` (synchronous SharedPreferences read) to render a filled or outline heart — works with zero network activity.
- Used in: `BookCard`, `DetailsScreen` app bar, `SearchScreen` results.

---

## Data Flow Diagram

```
App launch
    │
    ▼
WishlistCubit.getWishlist()
    │
    ├─ loading → ShimmerGridView
    │
    └─ API success
           │
           ├─ _mapWishlistResponse writes IDs to SharedPreferences
           └─ products shown in GridView
                    │
                    ▼
         User taps heart on any BookCard
                    │
                    ▼
         WishlistActionCubit.addOrRemoveFromWishlist(id)
                    │
                    ├─ SharedPref updated immediately  ← offline-first
                    ├─ heart icon flips instantly
                    │
                    └─ API call (async)
                              │
                         success → SharedPref re-synced from server
                         failure → SharedPref rolled back, error state
```

---

## Known Limitations

| Limitation | Impact |
|---|---|
| Full product data not cached | If `getWishlist()` fails (no internet on first load), the wishlist screen stays on shimmer forever — no cached books to display |
| No pending-actions queue | If the user toggles a book offline and the rollback fires, the action is lost — no retry on reconnect |
| No connectivity detection | The app always fires the network call; it only discovers failure after the request times out |
| Error state shows shimmer | `WishlistErrorState` renders the same shimmer as loading — users get no feedback when the API fails |
| Static repository | `WishlistRepo` has no interface, so it cannot be swapped or unit-tested in isolation |

---

## Files Reference

| File | Role |
|---|---|
| `lib/core/services/local/shared_pref.dart` | Local cache (IDs only) |
| `lib/features/wishlist/data/repo/wishlist_repo.dart` | API calls + cache sync |
| `lib/features/wishlist/presentation/wishlist_action/cubit/wishlist_action_cubit.dart` | Optimistic update logic |
| `lib/features/wishlist/presentation/wishlist_action/cubit/wishlist_action_state.dart` | Action states |
| `lib/features/wishlist/presentation/wishlist/cubit/wishlist_cubit.dart` | List fetch cubit |
| `lib/features/wishlist/presentation/wishlist/cubit/wishlist_state.dart` | List states |
| `lib/features/wishlist/presentation/wishlist/widgets/wishlist_books.dart` | List UI |
| `lib/features/wishlist/presentation/wishlist_action/widgets/wishlist_action.dart` | Heart-icon widget |
