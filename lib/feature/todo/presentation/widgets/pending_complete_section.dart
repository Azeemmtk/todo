import 'package:flutter/material.dart';
import 'package:todo/feature/todo/presentation/provider/bloc/todobloc/todo_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/feature/todo/presentation/widgets/pending_complete_widget.dart';
import '../../../../core/color.dart';

class PendingCompleteSection extends StatelessWidget {
  const PendingCompleteSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        int pending= 0;
        int completed= 0;
        int total= 0;

        if(state is TodoLoaded){
          total = state.todos.length;
          completed = state.todos.where((todo) => todo.isComplete).length;
          pending = state.todos.where((todo) => !todo.isComplete).length;
        }

        return SizedBox(
          width: width - 2 * padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PendingCompleteWidget(title: 'Pending', count: pending.toString()),
              PendingCompleteWidget(
                title: 'Completed',
                count: '$completed/$total',
                isCompleted: true,
              ),
            ],
          ),
        );
      },
    );
  }
}
