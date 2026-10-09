// SizedBox(height: 5);

// 5.h
// horizontalSpace(5)

import 'package:flutter/material.dart';
import 'package:taskati/core/services/local/hive_provider.dart';

extension Spacing on num {
  Widget get h {
    return SizedBox(height: toDouble());
  }

  Widget get w {
    return SizedBox(width: toDouble());
  }
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  bool get isDark => HiveProvider.getData(HiveProvider.kIsDark) ?? false;
}
