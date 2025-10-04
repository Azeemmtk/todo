import 'package:dartz/dartz.dart';

import '../../../../core/failures/failure.dart';
import '../../domain/entity/todo.dart';
import '../../domain/repository/todo_repository.dart';
import '../datasource/todo_data_source.dart';
import '../model/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoDataSource dataSource;

  TodoRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {

    try {
      print('try');
      final todoModels = await dataSource.getTodo();
      final todos = todoModels.map((model) => model.toEntity()).toList();

      return Right(todos);
    } catch (e, stackTrace) {
      print('Caught error: $e');
      print('Stack trace: $stackTrace');
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addTodo(Todo todo) async {
    try {
      final todoModel = TodoModel(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        dueDate: todo.dueDate,
        isComplete: todo.isComplete,
      );
      await dataSource.addTodo(todoModel);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateTodo( Todo todo) async {
    try {
      final todoModel = TodoModel(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        dueDate: todo.dueDate,
        isComplete: todo.isComplete,
      );
      await dataSource.updateTodo(todoModel);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodo(String id) async {
    try {
      await dataSource.deleteTodo(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> searchTodos(String query) async {
    try {
      final todoModels = await dataSource.searchTodo(query);
      final todos = todoModels.map((model) => model.toEntity()).toList();
      return Right(todos);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}