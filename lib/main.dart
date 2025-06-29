import 'package:flutter/material.dart';
import 'package:todo_list_using_isar/core/app_theme/app_theme.dart';
import 'package:todo_list_using_isar/feature/todo_list/presentation/pages/todo_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: TodoHomePage(),
    );
  }
}
