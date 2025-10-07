import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/color.dart';
import 'package:todo/feature/todo/presentation/provider/bloc/todobloc/todo_bloc.dart';
import 'package:todo/feature/todo/presentation/widgets/todo_card.dart';

class TodoListSection extends StatelessWidget {
  const TodoListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(padding),
      child: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TodoLoaded) {
            if (state.todos.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: Column(
                  children: [
                    SizedBox(height: height * 0.16),
                    Image.asset('assets/notepad_icon.png'),
                    Text(
                      'You don’t have any tasks yet.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'Start adding tasks and manage your time effectively.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            }
            return ListView.separated(
              key: ValueKey(state.todos.length),
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return TodoCard(
                  key: ValueKey(todo.id),
                  title: todo.title,
                  subtitle: todo.description,
                  date: todo.dueDate,
                  isCompleted: todo.isComplete,
                  id: todo.id!,
                );
              },
              separatorBuilder: (context, index) =>
                  SizedBox(height: height * 0.01),
              itemCount: state.todos.length,
            );
          } else if (state is TodoError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No todos available'));
        },
      ),
    );
  }
}