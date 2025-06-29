import 'package:flutter/material.dart';
import 'package:todo_list_using_isar/core/app_pallete/app_pallete.dart';

void snackBar(BuildContext context, String message, {bool isError = false}) {
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: isError ? error : null),
    );
  }
}
