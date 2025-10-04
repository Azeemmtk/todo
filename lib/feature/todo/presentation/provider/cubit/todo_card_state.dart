part of 'todo_card_cubit.dart';

@immutable
class TodoCardState {
  final bool isHidden;
  final bool isCompleted;

  const TodoCardState({required this.isHidden, required this.isCompleted});
}