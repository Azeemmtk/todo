import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/core/color.dart';
import 'package:todo/core/di/injection.dart';
import 'package:todo/core/util.dart';
import 'package:todo/feature/todo/domain/entity/todo.dart';
import 'package:todo/feature/todo/presentation/provider/bloc/todobloc/todo_bloc.dart';
import 'package:todo/feature/todo/presentation/provider/cubit/todo_card_cubit.dart';
import '../../presentation/widgets/add_edit_pop_up.dart';
import 'delete_button_widget.dart';

class TodoCard extends StatelessWidget {
  final String title;
  final String id;
  final String subtitle;
  final DateTime date;
  final bool isCompleted;

  const TodoCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.isCompleted,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TodoCardCubit>(param1: isCompleted),
      child: BlocBuilder<TodoCardCubit, TodoCardState>(
        builder: (context, state) => Card(
          color: boxColor,
          child: InkWell(
            onTap: () => context.read<TodoCardCubit>().hideToggle(),
            child: ListTile(
              leading: Radio<bool>(
                value: true,
                groupValue: state.isCompleted,
                toggleable: true,
                onChanged: (value) {
                  context.read<TodoCardCubit>().isCompletedToggle();
                  context.read<TodoBloc>().add(
                    UpdateTodoEvent(
                      Todo(
                        id: id,
                        title: title,
                        description: subtitle,
                        dueDate: date,
                        isComplete: !state.isCompleted,
                      ),
                    ),
                  );
                },
              ),
              title: Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      decoration: state.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: state.isCompleted ? Colors.grey : onSurface,
                    ),
                  ),
                  Spacer(),
                  Text(
                    dateFormat.format(date),
                    style: TextStyle(
                      fontSize: 13,
                      decoration: state.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: state.isCompleted ? Colors.grey : onSurface,
                    ),
                  ),
                ],
              ),
              subtitle: state.isHidden
                  ? null
                  : Text(
                subtitle,
                style: TextStyle(
                  decoration: state.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: state.isCompleted ? Colors.grey : onSurface,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AddEditPopup(
                          id: id,
                          initialDate: date,
                          initialTitle: title,
                          initialDescription: subtitle,
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.edit_note_sharp,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 10),
                  DeleteButtonWidget(title: title, id: id),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}