import 'package:flutter/material.dart';
import 'package:taskati/core/functions/extensions.dart';

void showErrorDialog(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: context.theme.colorScheme.error,
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 60),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Text(message),
    ),
  );
}
