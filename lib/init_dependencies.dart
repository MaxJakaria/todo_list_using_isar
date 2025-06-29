import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list_using_isar/feature/todo_list/data/datasources/todo_local_data_source.dart';
import 'package:todo_list_using_isar/feature/todo_list/data/datasources/todo_local_data_source_impl.dart';
import 'package:todo_list_using_isar/feature/todo_list/data/models/todo_model.dart';
import 'package:todo_list_using_isar/feature/todo_list/data/repositories/todo_repository_impl.dart';
import 'package:todo_list_using_isar/feature/todo_list/domain/repositories/todo_repository.dart';
import 'package:todo_list_using_isar/feature/todo_list/domain/usecases/add_todo.dart';
import 'package:todo_list_using_isar/feature/todo_list/domain/usecases/delete_todo.dart';
import 'package:todo_list_using_isar/feature/todo_list/domain/usecases/get_todos.dart';
import 'package:todo_list_using_isar/feature/todo_list/domain/usecases/update_todo.dart';
import 'package:todo_list_using_isar/feature/todo_list/domain/usecases/watch_todos.dart';
import 'package:todo_list_using_isar/feature/todo_list/presentation/bloc/todo_bloc.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  // Isar
  final dir = await getApplicationCacheDirectory();
  final isar = await Isar.open([TodoModelSchema], directory: dir.path);
  serviceLocator.registerSingleton<Isar>(isar);
  // Local data source
  serviceLocator.registerLazySingleton<TodoLocalDataSource>(
    () => TodoLocalDataSourceImpl(isar: serviceLocator()),
  );

  // Repository
  serviceLocator.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(todoLocalDataSource: serviceLocator()),
  );

  // Use cases
  serviceLocator.registerLazySingleton(
    () => AddTodo(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => DeleteTodo(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => UpdateTodo(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => GetTodos(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => WatchTodos(repository: serviceLocator()),
  );

  // Bloc
  serviceLocator.registerFactory(
    () => TodoBloc(
      addTodo: serviceLocator(),
      deleteTodo: serviceLocator(),
      updateTodo: serviceLocator(),
      getTodos: serviceLocator(),
      watchTodos: serviceLocator(),
    ),
  );
}
