import 'package:dartz/dartz.dart';

import '../../../../core/failures/failure.dart';
import '../entity/todo.dart';
import '../repository/todo_repository.dart';

class SearchTodos {
  final TodoRepository repository;

  SearchTodos(this.repository);

  Future<Either<Failure, List<Todo>>> call(String query) async {
    return await repository.searchTodos(query);
  }
}