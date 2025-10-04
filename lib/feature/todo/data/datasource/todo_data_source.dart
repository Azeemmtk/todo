import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/feature/todo/data/model/todo_model.dart';

abstract class TodoDataSource {
  Future<List<TodoModel>> getTodo();
  Future<void> addTodo(TodoModel todo);
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteTodo(String id);
  Future<List<TodoModel>> searchTodo(String query);
}

class TodoDataSourceImpl extends TodoDataSource {
  final FirebaseFirestore firestore;

  TodoDataSourceImpl({required this.firestore});

  @override
  Future<void> addTodo(TodoModel todo) async {
    await firestore.collection('todos').add(todo.toFireStore());
  }

  @override
  Future<void> deleteTodo(String id) async {
    await firestore.collection('todos').doc(id).delete();
  }

  @override
  Future<List<TodoModel>> getTodo() async {
    final querySnapshot = await firestore.collection('todos').get();
    print(querySnapshot.docs.length);
    return querySnapshot.docs.map((e) => TodoModel.fromFireStore(e)).toList();
  }

  @override
  Future<List<TodoModel>> searchTodo(String query) async {
    final querySnapshot = await firestore.collection('todos').get();
    final allTodo = querySnapshot.docs
        .map((e) => TodoModel.fromFireStore(e))
        .toList();

    if (query.isEmpty) {
      return allTodo;
    }
    return allTodo
        .where(
          (todo) =>
      todo.title.toLowerCase().contains(query.toLowerCase()) ||
          todo.description.toLowerCase().contains(query.toLowerCase()),
    )
        .toList();
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    await firestore.collection('todos').doc(todo.id).update(todo.toFireStore());
  }
}