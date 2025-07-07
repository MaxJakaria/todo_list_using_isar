import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_using_isar/core/common/text_field_config.dart';
import 'package:todo_list_using_isar/feature/todo_list/presentation/bloc/todo_bloc.dart';
import 'package:todo_list_using_isar/feature/todo_list/presentation/widgets/todo_dialog.dart';

Future<void> showTodoAddDialog({required BuildContext context}) async {
  await showDialog<Map<String, String>>(
    context: context,
    builder: (_) => TodoDialog(
      dialogTitle: 'Add New Todo',
      fields: const [
        TextFieldConfig(
          id: 'todoTitle',
          labelText: 'Title',
          isBlankError: true,
        ),
        TextFieldConfig(id: 'todoDetails', labelText: 'Details', maxLines: 4),
      ],
      actionButtonText: 'Add',
      onAction: (data) {
        context.read<TodoBloc>().add(
          AddTodoEvent(
            title: data['todoTitle']!,
            details: data['todoDetails']!,
            isComplete: false,
            updatedAt: DateTime.now(),
            scheduledTime: DateTime.now(), // temp data
          ),
        );
        Navigator.pop(context);
      },
      onCancel: () => Navigator.pop(context),
    ),
  );
}
