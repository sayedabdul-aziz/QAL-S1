import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void pushTo(BuildContext context, String location, {Object? extra}) {
  context.push(location, extra: extra);
}

void pushReplacement(BuildContext context, String location, {Object? extra}) {
  context.pushReplacement(location, extra: extra);
}

void replace(BuildContext context, String location, {Object? extra}) {
  context.replace(location, extra: extra);
}

void pushToBase(BuildContext context, String location, {Object? extra}) {
  context.go(location, extra: extra);
}

void pop(BuildContext context) {
  context.pop();
}

// go_router
