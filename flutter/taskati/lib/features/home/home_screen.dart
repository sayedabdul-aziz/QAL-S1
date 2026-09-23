import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:taskati/core/widgets/my_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box('userBox');
    return MyScaffold(
      body: Center(
        child: Column(
          spacing: 50,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (box.get("image") != null)
              ClipOval(
                child: Image.file(
                  File(box.get("image")),
                  height: 180,
                  width: 180,
                  fit: BoxFit.cover,
                ),
              ),

            Text("name:${box.get("name")}"),
          ],
        ),
      ),
    );
  }
}
