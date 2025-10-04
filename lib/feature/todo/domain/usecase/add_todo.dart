import 'package:dartz/dartz.dart';

import '../../../../core/failures/failure.dart';
import '../entity/todo.dart';
import '../repository/todo_repository.dart';

class AddTodo {
  final TodoRepository repository;

  AddTodo(this.repository);

  Future<Either<Failure, void>> call(Todo todo) async {
    if (todo.title.isEmpty || todo.description.isEmpty) {
      return Left(ValidationFailure('Title and description cannot be empty'));
    }
    return await repository.addTodo(todo);
  }
}