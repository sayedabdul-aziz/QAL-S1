# Debouncing Technique

## What is Debouncing?

**Debouncing** is a technique that limits how often a function is called by delaying its execution until a specified amount of time has passed since the **last** invocation. If the function is called again before the timer expires, the timer resets.

```
User types: B  →  Bo  →  Boo  →  Book
              ↑      ↑      ↑      ↑
           reset  reset  reset   FIRE  ← only one API call after 500 ms of silence
```

---

## Why Use It?

Without debouncing, every keystroke in a search field would trigger an API call:

| Keystroke | Without Debounce | With Debounce (500 ms) |
|-----------|-----------------|------------------------|
| `B`       | API call ✗      | timer starts           |
| `Bo`      | API call ✗      | timer resets           |
| `Boo`     | API call ✗      | timer resets           |
| `Book`    | API call ✗      | timer resets           |
| *(pause)* | —               | **API call ✓**         |

**Benefits:**
- 🔥 Reduces unnecessary network requests
- 💰 Saves API quota / server costs
- ⚡ Prevents UI jank from overlapping responses
- 🔒 Avoids race conditions between rapid requests

---

## Implementation in Dart / Flutter

### Core Pattern

```dart
import 'dart:async';

Timer? _debounceTimer;
static const _debounceDuration = Duration(milliseconds: 500);

void onQueryChanged(String query) {
  // 1. Cancel the previous timer (if still running)
  _debounceTimer?.cancel();

  // 2. Start a new timer
  _debounceTimer = Timer(_debounceDuration, () {
    // 3. This runs only if no new call arrives within 500 ms
    _doExpensiveWork(query);
  });
}
```

### Real Example — `SearchCubit`

From [search_cubit.dart](../lib/features/search/presentation/cubit/search_cubit.dart):

```dart
Timer? _debounceTimer;
static const _debounceDuration = Duration(milliseconds: 500);

void onQueryChanged(String query) {
  _debounceTimer?.cancel();               // reset the clock

  final trimmed = query.trim();

  if (trimmed.isEmpty) {
    products.clear();
    _currentQuery = '';
    emit(SearchInitialState());
    return;                               // bail early, no timer needed
  }

  emit(SearchLoadingState());             // show shimmer immediately (UX)

  _debounceTimer = Timer(_debounceDuration, () {
    _search(trimmed, page: 1);            // fired once, after silence
  });
}

@override
Future<void> close() {
  _debounceTimer?.cancel();              // ⚠️ always cancel on dispose!
  return super.close();
}
```

> **Note:** The shimmer is emitted *immediately* (before the timer fires) so the UI feels responsive even while waiting.

---

## Choosing the Right Duration

| Use Case              | Suggested Delay |
|-----------------------|-----------------|
| Search field (API)    | 400 – 600 ms    |
| Search field (local)  | 100 – 200 ms    |
| Window / scroll resize| 100 – 250 ms    |
| Form auto-save        | 1000 – 2000 ms  |
| Button rapid-click guard | 300 – 500 ms |

---

## Debounce vs. Throttle

| | Debounce | Throttle |
|---|---|---|
| **Fires when** | after silence | at a fixed interval |
| **Good for** | search input, auto-save | scroll, resize, analytics |
| **Guarantees first call** | ✗ (delays it) | ✓ |
| **Guarantees last call** | ✓ | ✗ (may skip it) |

---

## Common Pitfalls

### ❌ Forgetting to cancel on dispose
```dart
// BAD – timer fires after the cubit/widget is destroyed → setState on dead object
@override
void dispose() {
  super.dispose(); // timer still alive!
}
```

```dart
// GOOD
@override
Future<void> close() {
  _debounceTimer?.cancel();
  return super.close();
}
```

### ❌ Creating a new timer object without cancelling the old one
```dart
// BAD – old timer still fires!
_debounceTimer = Timer(_debounceDuration, callback);
```

```dart
// GOOD
_debounceTimer?.cancel();
_debounceTimer = Timer(_debounceDuration, callback);
```

### ❌ Debouncing inside `build()` or `initState()`
The timer variable must live at the **class level**, not inside a method that runs on every frame.

---

## Reusable Debouncer Utility

For repeated use across the app, extract a helper class:

```dart
import 'dart:async';

class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({this.delay = const Duration(milliseconds: 500)});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void cancel() => _timer?.cancel();
}
```

**Usage:**
```dart
final _debouncer = Debouncer(delay: Duration(milliseconds: 500));

void onChanged(String value) {
  _debouncer.run(() => _search(value));
}

@override
Future<void> close() {
  _debouncer.cancel();
  return super.close();
}
```
