import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_using_isar/core/app_theme/app_theme.dart';
import 'package:todo_list_using_isar/feature/todo_list/presentation/bloc/todo_bloc.dart';
import 'package:todo_list_using_isar/feature/todo_list/presentation/pages/todo_home_page.dart';
import 'package:todo_list_using_isar/init_dependencies.dart';

void main() async {
  initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          serviceLocator<TodoBloc>()..add(StartWatchTodosEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        home: TodoHomePage(),
      ),
    );
  }
}
