import 'package:flutter/material.dart';

void pushTo(BuildContext context, String routeName) {
  Navigator.pushNamed(context, routeName);
}

void pushReplacement(BuildContext context, String routeName) {
  Navigator.pushReplacementNamed(context, routeName);
}

void pop(BuildContext context) {
  Navigator.pop(context);
}

// go_router
