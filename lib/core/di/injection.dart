import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/feature/todo/data/repository/todo_repository_impl.dart';
import 'package:todo/feature/todo/domain/repository/todo_repository.dart';

import '../../feature/todo/data/datasource/todo_data_source.dart';
import '../../feature/todo/domain/usecase/add_todo.dart';
import '../../feature/todo/domain/usecase/delete_todo.dart';
import '../../feature/todo/domain/usecase/get_todo.dart';
import '../../feature/todo/domain/usecase/search_todo.dart';
import '../../feature/todo/domain/usecase/update_todo.dart';
import '../../feature/todo/presentation/provider/cubit/todo_card_cubit.dart';

final getIt = GetIt.instance;

void initializeDependencies() {
  //External
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  ///data Source
  getIt.registerLazySingleton<TodoDataSource>(
    () => TodoDataSourceImpl(firestore: getIt<FirebaseFirestore>()),
  );

  ///repository
  getIt.registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl(getIt<TodoDataSource>()),);

  /// Use cases
  getIt.registerLazySingleton(() => GetTodos(getIt<TodoRepository>()));
  getIt.registerLazySingleton(() => AddTodo(getIt<TodoRepository>()));
  getIt.registerLazySingleton(() => UpdateTodo(getIt<TodoRepository>()));
  getIt.registerLazySingleton(() => DeleteTodo(getIt<TodoRepository>()));
  getIt.registerLazySingleton(() => SearchTodos(getIt<TodoRepository>()));

  //cubits
  getIt.registerFactoryParam<TodoCardCubit, bool, void>(
    (isCompleted, _) => TodoCardCubit(isCompleted: isCompleted),
  );
}
