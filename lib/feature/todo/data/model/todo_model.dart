import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entity/todo.dart';

class TodoModel {
  String? id;
  String title;
  String description;
  DateTime dueDate;
  bool isComplete;

  TodoModel({
    this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.isComplete,
  });

  //from firebase
  factory TodoModel.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return TodoModel(
      id: doc.id,
      title: data['title'] as String? ?? '' ,
      description: data['description'] as String? ?? '',
      dueDate: (data['dueDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isComplete: data['isComplete'] as bool? ?? false,
    );
  }

  //to firebase
  Map<String, dynamic> toFireStore() {
    return {
      'title': title,
      'description': description,
      'dueDate': Timestamp.fromDate(dueDate),
      'isComplete': isComplete,
    };
  }

  Todo toEntity() {
    return Todo(
      id: id,
      title: title,
      description: description,
      dueDate: dueDate,
      isComplete: isComplete,
    );
  }
}
