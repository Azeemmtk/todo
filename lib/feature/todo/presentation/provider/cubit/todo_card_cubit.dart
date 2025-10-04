import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'todo_card_state.dart';

class TodoCardCubit extends Cubit<TodoCardState> {
  TodoCardCubit({required bool isCompleted})
      : super(TodoCardState(isHidden: true, isCompleted: isCompleted));

  void hideToggle() {
    emit(TodoCardState(
      isHidden: !state.isHidden,
      isCompleted: state.isCompleted,
    ));
  }

  void isCompletedToggle() {
    emit(TodoCardState(
      isHidden: state.isHidden,
      isCompleted: !state.isCompleted,
    ));
  }
}