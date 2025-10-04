import 'package:flutter/material.dart';
import '../widgets/add_search_section.dart';
import '../widgets/pending_complete_section.dart';
import '../widgets/todo_list_section.dart';

class TodoHomeScreen extends StatelessWidget {
  const TodoHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(backgroundColor: Colors.black, title: Text('Todo')),
      body: Column(
        children: [
          AddSearchSectionSection(),
          PendingCompleteSection(),
          Expanded(child: TodoListSection()),
        ],
      ),
    );
  }
}
