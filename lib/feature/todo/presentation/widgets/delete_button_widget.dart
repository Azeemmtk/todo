import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/color.dart';
import '../provider/bloc/todobloc/todo_bloc.dart';

class DeleteButtonWidget extends StatelessWidget {
  const DeleteButtonWidget({
    super.key,
    required this.title,
    required this.id,
  });

  final String title;
  final String id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final confirm = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text(
              'Delete Todo',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text('Are you sure you want to delete "$title"?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Delete', style: TextStyle(color: onSurface),),
              ),
            ],
          ),
        );

        if (confirm == true) {
          context.read<TodoBloc>().add(DeleteTodoEvent(id));

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '$title deleted',
                style: TextStyle(color: onSurface),
              ),
              duration: const Duration(seconds: 4),
              backgroundColor: primary,
            ),
          );
        }
      },
      child: const Icon(Icons.delete_outline, color: Colors.grey),
    );
  }
}