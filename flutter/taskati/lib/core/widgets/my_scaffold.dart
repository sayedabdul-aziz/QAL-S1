import 'package:flutter/material.dart';
import 'package:taskati/core/constants/app_images.dart';

class MyScaffold extends StatelessWidget {
  const MyScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.padding,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });
  final Widget body;
  final PreferredSizeWidget? appBar;
  final EdgeInsets? padding;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(0), child: AppBar()),
      body: Stack(
        children: [
          Image.asset(
            AppImages.background,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: appBar,
            body: Padding(
              padding: padding ?? const EdgeInsets.all(20),
              child: body,
            ),
            bottomNavigationBar: bottomNavigationBar,
            floatingActionButton: floatingActionButton,
          ),
        ],
      ),
    );
  }
}
