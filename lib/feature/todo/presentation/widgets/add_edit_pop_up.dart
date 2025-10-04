import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/color.dart';
import 'package:todo/core/util.dart';
import 'package:todo/feature/todo/presentation/provider/bloc/todobloc/todo_bloc.dart';

import '../../domain/entity/todo.dart';

class AddEditPopup extends StatefulWidget {
  final String? initialTitle;
  final String? initialDescription;
  final bool? isComplete;
  final String? id;
  final DateTime? initialDate;

  const AddEditPopup({
    super.key,
    this.initialTitle,
    this.initialDescription,
    this.initialDate,
    this.isComplete,
    this.id,
  });

  @override
  State<AddEditPopup> createState() => _AddEditPopupState();
}

class _AddEditPopupState extends State<AddEditPopup> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  DateTime? selectedDate;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.initialTitle ?? '');
    descriptionController = TextEditingController(text: widget.initialDescription ?? '');
    selectedDate = widget.initialDate;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return BlocListener<TodoBloc, TodoState>(
      listener: (context, state) {
        if(state is TodoError){
          setState(() {
            errorMessage = state.message;
          });
        }
    },
      child: AlertDialog(
        title: Text(widget.initialTitle == null ? "Add Todo" : "Edit Todo"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title field
              Container(
                width: width * 0.7,
                height: height * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: boxColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: 'Title',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Description field
              Container(
                width: width * 0.7,
                height: height * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: boxColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Date picker
              ElevatedButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
                child: Text(
                  selectedDate == null
                      ? "Select Date"
                      : "Selected: ${dateFormat.format(selectedDate!)}",
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                errorMessage=  null;
              });
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty &&
                  descriptionController.text.isNotEmpty &&
                  selectedDate != null) {
                final todo = Todo(
                  id: widget.id,
                  title: titleController.text,
                  description: descriptionController.text,
                  dueDate: selectedDate!,
                  isComplete: widget.isComplete ?? false,
                );
                if (widget.id == null) {
                  context.read<TodoBloc>().add(AddTodoEvent(todo));
                } else {
                  context.read<TodoBloc>().add(UpdateTodoEvent( todo));
                }
                setState(() {
                  errorMessage = null;
                });
                Navigator.pop(context);
              } else {
                setState(() {
                  errorMessage = 'Please fill all fields';
                });
              }
            },
            child: Text(widget.initialTitle == null ? "Save" : "Update"),
          ),
        ],
      ),
    );
  }
}
