# Hive Usage in Taskati

This document covers how **Hive CE** (Community Edition) is used as the local database in the Taskati Flutter project.

---

## Dependencies

```yaml
# pubspec.yaml
dependencies:
  hive_ce: ^2.20.0
  hive_ce_flutter: ^2.3.4

dev_dependencies:
  hive_ce_generator: ^1.11.3
  build_runner: ^2.16.1
```

---

## Initialization

Hive is initialized in `main.dart` before `runApp`:

```dart
// main.dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveProvider.init();
  runApp(const MainApp());
}
```

The `HiveProvider.init()` method handles the full setup:

```dart
// lib/core/services/local/hive_provider.dart
static Future<void> init() async {
  await Hive.initFlutter();        // 1. Initialize Hive with app documents directory
  Hive.registerAdapters();         // 2. Register all generated TypeAdapters
  _userBox = await Hive.openBox(kUserBox);             // 3. Open untyped user box
  _taskBox = await Hive.openBox<TaskModel>(kTaskBox);  // 4. Open typed task box
}
```

---

## HiveProvider — Central Service

All Hive access is centralized in `lib/core/services/local/hive_provider.dart`. It uses **static methods** so no instance is needed.

### Box Constants

| Constant   | Value        | Type             | Purpose                      |
|------------|--------------|------------------|------------------------------|
| `kUserBox` | `'userBox'`  | `Box` (dynamic)  | User preferences (name, image, dark mode) |
| `kTaskBox` | `'taskBox'`  | `Box<TaskModel>` | Task objects                 |

### Key Constants (userBox)

| Constant | Value      | Type   | Purpose                   |
|----------|------------|--------|---------------------------|
| `kName`  | `'name'`   | String | User's display name       |
| `kImage` | `'image'`  | String | File path to profile image|
| `kIsDark`| `'isDark'` | bool   | Dark mode toggle          |

### Helper Methods

```dart
// --- userBox ---
static Future<void> cacheData(String key, dynamic value) async {
  await _userBox.put(key, value);
}

static dynamic getData(String key) {
  return _userBox.get(key);
}

static Future<void> cacheUserData({required String name, required String imagePath}) async {
  await cacheData(HiveProvider.kName, name);
  await cacheData(HiveProvider.kImage, imagePath);
}

// --- taskBox ---
static Future<void> cacheTask(String key, TaskModel value) async {
  await _taskBox.put(key, value);
}

static TaskModel? getTask(String key) {
  return _taskBox.get(key);
}
```

---

## TaskModel

Defined in `lib/core/models/task_model.dart`:

```dart
class TaskModel {
  String? id;
  String? title;
  String? description;
  String? date;
  String? startTime;
  String? endTime;
  bool? isCompleted;

  TaskModel({ this.id, this.title, this.description, this.date,
              this.startTime, this.endTime, this.isCompleted });

  TaskModel copyWith({ ... });
}
```

---

## TypeAdapter (Auto-Generated)

### Adapter Declaration

```dart
// lib/core/hive/hive_adapters.dart
@GenerateAdapters([AdapterSpec<TaskModel>()])
part 'hive_adapters.g.dart';
```

### Generated Files

| File                         | Purpose                                  |
|------------------------------|------------------------------------------|
| `hive_adapters.g.dart`       | `TaskModelAdapter` class (typeId = 0)    |
| `hive_adapters.g.yaml`       | Metadata tracking field indices & typeIds|
| `hive_registrar.g.dart`      | `registerAdapters()` extension on `HiveInterface` |

### Regenerate Adapters

```bash
dart run build_runner build
```

---

## CRUD Operations

### Create

**Create a task** — `create_edit_task_screen.dart`:

```dart
// Generate unique key
String key = DateTime.now().millisecondsSinceEpoch.toString() + titleController.text;

var task = TaskModel(
  id: key,
  title: titleController.text,
  description: descriptionController.text,
  date: selectedDate,
  startTime: selectedStartTime,
  endTime: selectedEndTime,
  isCompleted: false,
);

await HiveProvider.cacheTask(key, task);
```

**Cache user data** — `upload_screen.dart`:

```dart
await HiveProvider.cacheUserData(name: name, imagePath: imagePath);
```

### Read

**Reactive reading with ValueListenableBuilder** — used for both tasks and theme:

```dart
// tasks_list_builder.dart — listen to task changes
ValueListenableBuilder<Box<TaskModel>>(
  valueListenable: HiveProvider.taskBox.listenable(),
  builder: (context, box, widget) {
    var tasks = box.values.toList();
    // filter by date and status...
  },
)

// main.dart — listen to theme changes
ValueListenableBuilder(
  valueListenable: HiveProvider.userBox.listenable(),
  builder: (context, value, child) {
    bool isDark = HiveProvider.getData(HiveProvider.kIsDark) ?? false;
    // rebuild MaterialApp with correct theme...
  },
)
```

**Direct reading:**

```dart
HiveProvider.getData(HiveProvider.kName)    // user's name
HiveProvider.getData(HiveProvider.kImage)   // profile image path
HiveProvider.getData(HiveProvider.kIsDark)  // dark mode bool
```

### Update

**Mark task as completed** — `task_card_slidable.dart`:

```dart
var task = taskModel.copyWith(isCompleted: true);
await HiveProvider.cacheTask(taskModel.id ?? '', task);
```

**Edit a task** — `create_edit_task_screen.dart` (same `cacheTask` call with existing ID).

**Toggle dark mode** — `home_header.dart`:

```dart
bool isDark = HiveProvider.getData(HiveProvider.kIsDark) ?? false;
HiveProvider.cacheData(HiveProvider.kIsDark, !isDark);
```

### Delete

**Delete a task** — `task_card_slidable.dart`:

```dart
HiveProvider.taskBox.delete(taskModel.id);
```

---

## Reactive UI Pattern

The project uses `ValueListenableBuilder` with `box.listenable()` for real-time UI updates — no external state management needed. When any value in the box changes, the builder rebuilds automatically.

Used in:
- `main.dart` — rebuilds the entire app when theme preference changes
- `tasks_list_builder.dart` — rebuilds task list when tasks are added/edited/deleted
- `daily_progress.dart` — recalculates progress when task completion status changes

---

## File Reference

| File | Role |
|------|------|
| `lib/core/services/local/hive_provider.dart` | Central Hive service |
| `lib/core/models/task_model.dart` | Data model stored in Hive |
| `lib/core/hive/hive_adapters.dart` | Adapter generation annotation |
| `lib/core/hive/hive_adapters.g.dart` | Generated TaskModelAdapter |
| `lib/core/hive/hive_registrar.g.dart` | Generated adapter registration |
| `lib/main.dart` | Initialization + reactive theme |
| `lib/features/upload/upload_screen.dart` | Caches user profile data |
| `lib/features/spalsh/splash_screen.dart` | Checks onboarding status |
| `lib/features/home/widgets/home_header.dart` | Reads user data, toggles dark mode |
| `lib/features/home/widgets/tasks_list_builder.dart` | Reactive task list |
| `lib/features/home/widgets/daily_progress.dart` | Reactive progress calculation |
| `lib/features/home/widgets/task_card_slidable.dart` | Task update & delete |
| `lib/features/create_task/page/create_edit_task_screen.dart` | Task create & edit |
