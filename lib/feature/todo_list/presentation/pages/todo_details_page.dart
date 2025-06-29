import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_using_isar/core/app_pallete/app_pallete.dart';
import 'package:todo_list_using_isar/core/common/snack_bar.dart';
import 'package:todo_list_using_isar/feature/todo_list/domain/entities/todo.dart';
import 'package:todo_list_using_isar/feature/todo_list/presentation/bloc/todo_bloc.dart';

class TodoDetailsPage extends StatefulWidget {
  static Route route(Todo todo) =>
      MaterialPageRoute(builder: (context) => TodoDetailsPage(todo: todo));

  final Todo todo;

  const TodoDetailsPage({super.key, required this.todo});

  @override
  State<TodoDetailsPage> createState() => _TodoDetailsPageState();
}

class _TodoDetailsPageState extends State<TodoDetailsPage> {
  late TextEditingController _titleController;
  late TextEditingController _detailsController;
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.todo.title);
    _detailsController = TextEditingController(text: widget.todo.details);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  void _toggleEditing() {
    setState(() {
      if (_isEditing) {
        // Cancel editing: revert changes
        _titleController.text = widget.todo.title;
        _detailsController.text = widget.todo.details;
      }
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() {
    if (!_formKey.currentState!.validate()) return;

    final updatedTitle = _titleController.text.trim();
    final updatedDetails = _detailsController.text.trim();

    context.read<TodoBloc>().add(
      UpdateTodoEvent(
        id: widget.todo.id,
        title: updatedTitle,
        details: updatedDetails,
        updatedAt: DateTime.now(),
        isComplete: widget.todo.isComplete,
      ),
    );

    snackBar(context, 'Todo updated');
    setState(() => _isEditing = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        title: Text(_titleController.text),
        actions: [
          if (_isEditing)
            IconButton(
              icon: const Icon(Icons.close),
              color: close,
              onPressed: _toggleEditing,
            ),
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit),
            color: edit,
            onPressed: _isEditing ? _saveChanges : _toggleEditing,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _isEditing
                  ? TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Title can\'t be empty!';
                        }
                        return null;
                      },
                    )
                  : Text(
                      _titleController.text,
                      style: theme.textTheme.titleLarge,
                    ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              _isEditing
                  ? TextFormField(
                      controller: _detailsController,
                      style: theme.textTheme.bodyLarge,
                      maxLines: null,
                      decoration: const InputDecoration(labelText: 'Details'),
                    )
                  : Text(
                      _detailsController.text,
                      style: theme.textTheme.bodyLarge,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
