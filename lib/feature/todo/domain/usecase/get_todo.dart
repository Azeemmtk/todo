import 'package:dartz/dartz.dart';

import '../../../../core/failures/failure.dart';
import '../entity/todo.dart';
import '../repository/todo_repository.dart';

class GetTodos {
  final TodoRepository repository;

  GetTodos(this.repository);

  Future<Either<Failure, List<Todo>>> call() async {
    return await repository.getTodos();
  }
}