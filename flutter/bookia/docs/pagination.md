# Pagination Technique

## What is Pagination?

**Pagination** is the process of splitting a large dataset into smaller **pages** and fetching them on demand, instead of loading everything at once.

```
Server has 200 books
         │
  ┌──────┴──────┐
  │  page 1     │  ← fetched on first search  (items 1–15)
  │  page 2     │  ← fetched when user scrolls near bottom (items 16–30)
  │  page 3     │  ← fetched on next scroll trigger         (items 31–45)
  │   ...       │
  └─────────────┘
```

---

## Why Use It?

| Without Pagination | With Pagination |
|--------------------|-----------------|
| Fetches all 200 items at once | Fetches 15 items at a time |
| High memory usage | Low memory usage |
| Slow initial load | Fast initial load |
| Wasted data if user stops scrolling | Only loads what the user sees |

---

## Pagination Types

| Type | How It Works | When to Use |
|------|-------------|-------------|
| **Page-based** | `?page=2&per_page=15` | Most REST APIs |
| **Offset-based** | `?offset=30&limit=15` | SQL-style backends |
| **Cursor-based** | `?cursor=abc123` | Feeds, real-time data |
| **Infinite scroll** | Auto-fetch next page on scroll | Mobile / social apps ✓ |
| **Load More button** | User taps to fetch next page | Blogs, dashboards |

This project uses **page-based + infinite scroll**.

---

## Implementation in this Project

### Layer 1 — API (`SearchRepo`)

The repo passes `page` to the endpoint:

```dart
// lib/features/search/data/repo/search_repo.dart
static Future<SearchResponse?> search({
  required String query,
  required int page,
}) async { ... }
```

### Layer 2 — State Management (`SearchCubit`)

From [search_cubit.dart](../lib/features/search/presentation/cubit/search_cubit.dart):

```dart
// ── state tracked across pages ────────────────────────────────────────────────
int _currentPage = 1;
int _lastPage    = 1;          // set from meta.last_page in the response
List<Product> products = [];   // accumulated across all loaded pages

bool get canLoadMore => _currentPage < _lastPage;

// ── load next page ────────────────────────────────────────────────────────────
Future<void> loadMore() async {
  if (!canLoadMore || state is SearchLoadingMoreState) return;  // guard
  emit(SearchLoadingMoreState());
  await _search(_currentQuery, page: _currentPage + 1);
}

// ── internal fetch ────────────────────────────────────────────────────────────
Future<void> _search(String query, {required int page}) async {
  _currentPage = page;

  if (page == 1) products.clear();          // fresh query → reset list

  final response = await SearchRepo.search(query: query, page: page);

  if (response?.data?.products != null) {
    products.addAll(response!.data!.products!);        // APPEND, not replace
    _lastPage     = response.data!.meta?.lastPage ?? 1;
    totalProducts = response.data!.meta?.total   ?? 0;

    emit(products.isEmpty ? SearchEmptyState() : SearchSuccessState());
  } else {
    if (page == 1) {
      emit(SearchErrorState());
    } else {
      _currentPage--;          // roll back so the user can retry
      emit(SearchSuccessState());
    }
  }
}
```

### Layer 3 — UI Scroll Listener (`SearchScreen`)

From [search_screen.dart](../lib/features/search/presentation/page/search_screen.dart):

```dart
final _scrollController = ScrollController();

@override
void initState() {
  super.initState();
  _scrollController.addListener(_onScroll);
}

void _onScroll() {
  final pos = _scrollController.position;
  // Fire 200 px BEFORE the bottom — feels instant to the user
  if (pos.pixels >= pos.maxScrollExtent - 200) {
    context.read<SearchCubit>().loadMore();
  }
}

@override
void dispose() {
  _searchController.dispose();
  _scrollController.dispose();   // ⚠️ always dispose!
  super.dispose();
}
```

### Layer 4 — UI List with Bottom Spinner

```dart
ListView.separated(
  controller: _scrollController,
  itemCount: products.length + (state is SearchLoadingMoreState ? 1 : 0),
  //                           ↑ extra slot for the spinner
  itemBuilder: (context, index) {
    if (index == products.length) {
      // This slot is only reachable when LoadingMore state is active
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return _SearchBookCard(product: products[index]);
  },
)
```

---

## Full Data-Flow Diagram

```
User scrolls near bottom
        │
        ▼
  _onScroll() fires
  pos.pixels >= pos.maxScrollExtent - 200
        │
        ▼
  cubit.loadMore()
        │
  canLoadMore? ──No──▶ stop
        │ Yes
        ▼
  emit(SearchLoadingMoreState)  ──▶ UI shows spinner at bottom
        │
        ▼
  SearchRepo.search(query, page: _currentPage + 1)
        │
        ▼
  products.addAll(newItems)
  _currentPage++
        │
        ▼
  emit(SearchSuccessState)  ──▶ UI appends new cards, hides spinner
```

---

## State Machine

```
SearchInitialState   ← nothing typed yet
      │  user types
      ▼
SearchLoadingState   ← page 1, show shimmer
      │  response ok
      ▼
SearchSuccessState   ← list visible
      │  user scrolls to bottom
      ▼
SearchLoadingMoreState  ← spinner at bottom of list
      │  response ok
      ▼
SearchSuccessState   ← more items appended
```

---

## `maxScrollExtent` Explained

`ScrollController.position` exposes two key values:

| Property | Meaning |
|----------|---------|
| `pixels` | Current scroll offset from the top (in logical pixels) |
| `maxScrollExtent` | Maximum scrollable distance (total content height − viewport height) |

When `pixels >= maxScrollExtent` the user is **exactly at the bottom**.  
The **200 px threshold** triggers the fetch *just before* the bottom, so new items land before the user runs out of list:

```
┌─────────────────┐  ← pixels = 0 (top)
│                 │
│   visible area  │
│                 │
└─────────────────┘
│   ...           │
│   ...           │
├─────────────────┤  ← maxScrollExtent - 200  ← loadMore() fires HERE
│                 │
│  last 200 px    │
│                 │
└─────────────────┘  ← maxScrollExtent (true bottom)
```

---

## Common Pitfalls

### ❌ Not guarding against duplicate requests

```dart
// BAD – scroll events fire many times per second
void _onScroll() {
  if (nearBottom) cubit.loadMore();   // fires 20× in one swipe
}
```

```dart
// GOOD – guard inside loadMore()
Future<void> loadMore() async {
  if (!canLoadMore || state is SearchLoadingMoreState) return;  // once only
  ...
}
```

### ❌ Replacing instead of appending

```dart
// BAD – user loses page 1 data
products = response.data!.products!;
```

```dart
// GOOD
products.addAll(response.data!.products!);
```

### ❌ Not resetting page on a new query

```dart
// BAD – new search continues from page 3
await _search(newQuery, page: _currentPage);
```

```dart
// GOOD – always start from page 1 on a fresh query
await _search(newQuery, page: 1);
// and inside _search:
if (page == 1) products.clear();
```

### ❌ Not rolling back on a failed page-N request

```dart
// BAD – _currentPage is now 4 but items for page 4 never loaded
_currentPage = page;
```

```dart
// GOOD
} else {
  if (page == 1) {
    emit(SearchErrorState());
  } else {
    _currentPage--;   // roll back so the next trigger retries page N
    emit(SearchSuccessState());
  }
}
```

### ❌ Forgetting to dispose the ScrollController

```dart
// BAD – memory leak
@override
void dispose() {
  super.dispose();   // controller still listening
}
```

```dart
// GOOD
@override
void dispose() {
  _scrollController.dispose();
  super.dispose();
}
```

---

## Choosing a Threshold

| Threshold | Effect |
|-----------|--------|
| `0` | Fires exactly at the bottom — may feel laggy |
| `200` *(this project)* | Fires 200 px before bottom — smooth on most devices |
| `screenHeight * 0.5` | Fires half a screen early — aggressive pre-fetch |

A good rule of thumb: **threshold ≈ the height of one page of items**.

---

## Related

- [[debouncing]] — prevents the search API from firing on every keystroke  
- `SearchCubit.canLoadMore` — boolean guard based on `_currentPage < _lastPage`  
- `meta.last_page` — the server field that tells the client when to stop
