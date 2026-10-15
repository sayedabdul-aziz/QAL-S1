# Theme Handling in Taskati

This document covers how light/dark theming is implemented, toggled, and persisted in the Taskati Flutter project.

---

## Architecture Overview

```
┌──────────────┐    persists     ┌──────────────┐    provides     ┌─────────────┐
│  HomeHeader  │ ──── isDark ──▶ │ HiveProvider │ ◀── listenable ─│   main.dart │
│ (toggle btn) │                 │  (userBox)   │                 │ (rebuilds   │
└──────────────┘                 └──────────────┘                 │  MaterialApp)│
                                                                  └─────────────┘
```

1. User taps the dark mode icon in `HomeHeader`
2. `HiveProvider` saves the boolean to `userBox`
3. `ValueListenableBuilder` in `main.dart` detects the change
4. `MaterialApp` rebuilds with the correct `ThemeData`

---

## Color Palettes

Defined in `lib/core/styles/app_colors.dart`:

### LightPalette

| Token            | Color                  | Hex         |
|------------------|------------------------|-------------|
| `background`     | White                  | `#FFFFFF`   |
| `primaryColor`   | Purple                 | `#5F33E1`   |
| `primaryColor100`| Light Purple           | `#8764FF`   |
| `secondaryColor` | Pale Purple            | `#EDE8FF`   |
| `textPrimary`    | Black                  | `#000000`   |
| `textInverse`    | White                  | `#FFFFFF`   |
| `greyColor`      | Grey                   | `#6E6A7C`   |
| `redColor`       | Red                    | `#EB5757`   |

### DarkPalette

| Token            | Color                  | Hex         |
|------------------|------------------------|-------------|
| `background`     | Dark Grey              | `#24252C`   |
| `primaryColor`   | Purple (same)          | `#5F33E1`   |
| `primaryColor100`| Light Purple (same)    | `#8764FF`   |
| `secondaryColor` | Pale Purple (same)     | `#EDE8FF`   |
| `textPrimary`    | White                  | `#FFFFFF`   |
| `textInverse`    | Black                  | `#000000`   |
| `greyColor`      | Grey (same)            | `#6E6A7C`   |
| `redColor`       | Red (same)             | `#EB5757`   |

The two palettes share `primaryColor`, `primaryColor100`, `secondaryColor`, `greyColor`, and `redColor`. They differ in `background`, `textPrimary`, and `textInverse` (inverted between modes).

---

## ThemeData Definitions

Defined in `lib/core/styles/themes.dart` via `AppThemes`:

```dart
class AppThemes {
  static ThemeData get lightTheme => ThemeData(...);
  static ThemeData get darkTheme  => ThemeData(...);
}
```

### What each theme configures

| Property                     | Light                           | Dark                            |
|------------------------------|---------------------------------|---------------------------------|
| `fontFamily`                 | Poppins                         | Poppins                         |
| `scaffoldBackgroundColor`    | `LightPalette.background`       | `DarkPalette.background`        |
| `primaryColor`               | `LightPalette.primaryColor`     | `DarkPalette.primaryColor`      |
| `hoverColor`                 | `DarkPalette.primaryColor100`   | `DarkPalette.primaryColor100`   |
| `splashColor`                | transparent                     | transparent                     |
| `highlightColor`             | transparent                     | transparent                     |

### ColorScheme Mapping

Both themes use `ColorScheme.fromSeed()` with semantic token mapping:

| ColorScheme slot   | Semantic use          | Light value                     | Dark value                      |
|--------------------|-----------------------|---------------------------------|---------------------------------|
| `seedColor`        | App theme color       | `LightPalette.primaryColor`     | `DarkPalette.primaryColor`      |
| `onSurface`        | Text color            | `LightPalette.textPrimary`      | `DarkPalette.textPrimary`       |
| `error`            | Error/red             | `LightPalette.redColor`         | `LightPalette.redColor`         |
| `inversePrimary`   | Inverse text          | `LightPalette.textInverse`      | `DarkPalette.textInverse`       |
| `secondary`        | Secondary/accent      | `LightPalette.secondaryColor`   | `LightPalette.secondaryColor`   |
| `tertiary`         | Grey/muted            | `LightPalette.greyColor`        | `LightPalette.greyColor`        |
| `surfaceContainer` | Surface variant       | `DarkPalette.textPrimary`       | `DarkPalette.textPrimary`       |

### Component Themes

**AppBar** — background matches scaffold, foreground matches text, centered title.

**InputDecoration** — filled with background color, no border, rounded corners (14px), hint in grey, error in red.

**DatePicker / TimePicker** — background matches scaffold, transparent surface tint. (TimePicker only customized in dark theme.)

**IconButton** — transparent hover and highlight.

**BottomNavigationBar** — transparent background, no elevation, fixed type, selected = primaryColor, unselected = textPrimary.

---

## Text Styles

Defined in `lib/core/styles/text_styles.dart` — theme-independent (no color set):

| Style       | Size | Weight     |
|-------------|------|------------|
| `headline1` | 30   | w600 (semi-bold) |
| `headline2` | 24   | w600       |
| `title1`    | 22   | w600       |
| `title2`    | 20   | w600       |
| `subtitle`  | 18   | w500 (medium) |
| `body`      | 16   | normal     |
| `caption1`  | 14   | normal     |
| `caption2`  | 12   | normal     |

Text color comes from the theme (via `colorScheme.onSurface`) or is applied inline with `.copyWith(color: ...)`.

---

## Font

Defined in `lib/core/constants/app_fonts.dart`:

```dart
class AppFonts {
  static const String poppins = 'Poppins';
}
```

Set globally via `ThemeData(fontFamily: AppFonts.poppins)`.

---

## Dark Mode Persistence

The dark mode preference is stored in Hive's `userBox` under the key `'isDark'` (bool).

### Toggle (HomeHeader)

```dart
// lib/features/home/widgets/home_header.dart
IconButton(
  icon: const Icon(Icons.dark_mode),
  onPressed: () {
    bool isDark = HiveProvider.getData(HiveProvider.kIsDark) ?? false;
    HiveProvider.cacheData(HiveProvider.kIsDark, !isDark);
  },
)
```

### Reactive Rebuild (main.dart)

```dart
// lib/main.dart
ValueListenableBuilder(
  valueListenable: HiveProvider.userBox.listenable(),
  builder: (context, value, child) {
    bool isDark = HiveProvider.getData(HiveProvider.kIsDark) ?? false;
    return MaterialApp(
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      // ...
    );
  },
)
```

No state management library is used — `ValueListenableBuilder` on the Hive box handles reactivity.

---

## Convenience Extensions

Defined in `lib/core/functions/extensions.dart`:

```dart
extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  bool get isDark => HiveProvider.getData(HiveProvider.kIsDark) ?? false;
}
```

Usage in widgets:

```dart
context.theme.primaryColor
context.colorScheme.secondary
context.isDark  // check current mode
```

---

## File Reference

| File | Role |
|------|------|
| `lib/core/styles/app_colors.dart` | `LightPalette` and `DarkPalette` color constants |
| `lib/core/styles/themes.dart` | `AppThemes.lightTheme` and `AppThemes.darkTheme` |
| `lib/core/styles/text_styles.dart` | `TextStyles` — theme-independent text styles |
| `lib/core/constants/app_fonts.dart` | `AppFonts.poppins` font family constant |
| `lib/core/functions/extensions.dart` | `context.theme`, `context.colorScheme`, `context.isDark` |
| `lib/core/services/local/hive_provider.dart` | Persists `isDark` preference in `userBox` |
| `lib/main.dart` | `ValueListenableBuilder` rebuilds app on theme change |
| `lib/features/home/widgets/home_header.dart` | Dark mode toggle button |
