import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/app_theme.dart';
import 'package:todo/core/di/injection.dart';
import 'package:todo/feature/todo/domain/usecase/add_todo.dart';
import 'package:todo/feature/todo/domain/usecase/delete_todo.dart';
import 'package:todo/feature/todo/domain/usecase/get_todo.dart';
import 'package:todo/feature/todo/domain/usecase/search_todo.dart';
import 'package:todo/feature/todo/domain/usecase/update_todo.dart';
import 'package:todo/feature/todo/presentation/provider/bloc/todobloc/todo_bloc.dart';
import 'feature/todo/presentation/screens/todo_home_screen.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //initialize dependencies
  initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TodoBloc(
          getTodos: getIt<GetTodos>(),
          addTodo: getIt<AddTodo>(),
          deleteTodo: getIt<DeleteTodo>(),
          searchTodos: getIt<SearchTodos>(),
          updateTodo: getIt<UpdateTodo>(),
        ),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: TodoHomeScreen(),
      ),
    );
  }
}