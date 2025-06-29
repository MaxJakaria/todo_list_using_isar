import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_using_isar/core/common/text_field_config.dart';
import 'package:todo_list_using_isar/feature/todo_list/presentation/bloc/todo_bloc.dart';
import 'package:todo_list_using_isar/feature/todo_list/presentation/widgets/todo_dialog.dart';

Future<void> showTodoEditDialog({
  required BuildContext context,
  required String id,
  required String initialTitle,
  required String initialDetails,
}) async {
  await showDialog<Map<String, String>>(
    context: context,
    builder: (_) => TodoDialog(
      dialogTitle: 'Edit Todo Item',
      fields: [
        TextFieldConfig(
          id: 'todoTitle',
          labelText: 'Title',
          initialValue: initialTitle,
          isBlankError: true,
        ),
        TextFieldConfig(
          id: 'todoDetails',
          labelText: 'Details',
          initialValue: initialDetails,
          maxLines: 4,
        ),
      ],
      actionButtonText: 'Update',
      onAction: (data) {
        context.read<TodoBloc>().add(
          UpdateTodoEvent(
            id: id,
            title: data['todoTitle'],
            details: data['todoDetails'],
            updatedAt: DateTime.now(),
          ),
        );
        Navigator.pop(context);
      },
      onCancel: () => Navigator.pop(context),
    ),
  );
}
