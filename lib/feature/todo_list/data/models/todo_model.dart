import 'package:isar/isar.dart';
import 'package:todo_list_using_isar/feature/todo_list/domain/entities/todo.dart';

part 'todo_model.g.dart';

@Collection()
class TodoModel extends Todo {
  Id isarId = Isar.autoIncrement; // Internal Isar ID

  @Index(unique: true) // Useful for queries by app-specific ID
  late String id;

  late String title;
  late String details;
  late bool isComplete;
  late DateTime updatedAt;

  TodoModel({
    required this.id,
    required this.title,
    required this.details,
    required this.isComplete,
    required this.updatedAt,
  }) : super(
         id: id,
         title: title,
         details: details,
         isComplete: isComplete,
         updatedAt: updatedAt,
       );

  // Conversion from domain entity
  factory TodoModel.fromEntity(TodoModel todo) {
    return TodoModel(
      id: todo.id,
      title: todo.title,
      details: todo.details,
      isComplete: todo.isComplete,
      updatedAt: todo.updatedAt,
    );
  }

  // Conversion to domain entity
  TodoModel toEntity() {
    return TodoModel(
      id: id,
      title: title,
      details: details,
      isComplete: isComplete,
      updatedAt: updatedAt,
    );
  }

  TodoModel copyWith({
    String? id,
    String? title,
    String? details,
    bool? isComplete,
    DateTime? updatedAt,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      details: details ?? this.details,
      isComplete: isComplete ?? this.isComplete,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
