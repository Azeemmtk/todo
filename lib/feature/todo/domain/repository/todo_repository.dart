import 'package:dartz/dartz.dart';

import '../../../../core/failures/failure.dart';
import '../entity/todo.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<Todo>>> getTodos();
  Future<Either<Failure, void>> addTodo(Todo todo);
  Future<Either<Failure, void>> updateTodo( Todo todo);
  Future<Either<Failure, void>> deleteTodo(String id);
  Future<Either<Failure, List<Todo>>> searchTodos(String query);
}