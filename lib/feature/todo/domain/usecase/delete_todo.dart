import 'package:dartz/dartz.dart';

import '../../../../core/failures/failure.dart';
import '../repository/todo_repository.dart';

class DeleteTodo {
  final TodoRepository repository;

  DeleteTodo(this.repository);

  Future<Either<Failure, void>> call(String id) async {
    if (id.isEmpty) {
      return Left(ValidationFailure('Todo ID cannot be empty'));
    }
    return await repository.deleteTodo(id);
  }
}