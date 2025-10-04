part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

class LoadTodosEvent extends TodoEvent{}

class AddTodoEvent extends TodoEvent{

  final Todo todo;
  AddTodoEvent(this.todo);

}

class UpdateTodoEvent extends TodoEvent{

  final Todo todo;

  UpdateTodoEvent(this.todo);

}

class DeleteTodoEvent extends TodoEvent{
  final String id;

  DeleteTodoEvent(this.id);

}
class SearchTodoEvent extends TodoEvent{

  final String query;

  SearchTodoEvent(this.query);

}
