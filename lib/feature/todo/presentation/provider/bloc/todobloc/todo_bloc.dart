import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/feature/todo/domain/usecase/add_todo.dart';
import 'package:todo/feature/todo/domain/usecase/delete_todo.dart';
import 'package:todo/feature/todo/domain/usecase/get_todo.dart';
import 'package:todo/feature/todo/domain/usecase/search_todo.dart';
import 'package:todo/feature/todo/domain/usecase/update_todo.dart';
import '../../../../domain/entity/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodos getTodos;
  final AddTodo addTodo;
  final DeleteTodo deleteTodo;
  final SearchTodos searchTodos;
  final UpdateTodo updateTodo;
  Timer? _debounce;

  TodoBloc({
    required this.getTodos,
    required this.addTodo,
    required this.deleteTodo,
    required this.searchTodos,
    required this.updateTodo,
  }) : super(TodoInitial()) {
    on<LoadTodosEvent>(_onLoadTodos);
    on<AddTodoEvent>(_onAddTodos);
    on<UpdateTodoEvent>(_onUpdateTodos);
    on<DeleteTodoEvent>(_onDeleteTodos);
    on<SearchTodoEvent>(_onSearchTodos);
  }

  Future<void> _onLoadTodos(LoadTodosEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    final result = await getTodos();
    result.fold(
          (failure) => emit(TodoError(message: failure.message)),
          (todos) => emit(TodoLoaded(todos: _sortTodos(todos))),
    );
  }

  Future<void> _onAddTodos(AddTodoEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    final result = await addTodo(event.todo);
    result.fold(
          (failure) => emit(TodoError(message: failure.message)),
          (_) {
        if (state is TodoLoaded) {
          final currentTodos = (state as TodoLoaded).todos;
          emit(TodoLoaded(todos: _sortTodos([...currentTodos, event.todo])));
        } else {
          add(LoadTodosEvent());
        }
      },
    );
  }

  Future<void> _onUpdateTodos(UpdateTodoEvent event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      final currentTodos = (state as TodoLoaded).todos;
      final updatedTodos = currentTodos.map((todo) {
        return todo.id == event.todo.id ? event.todo : todo;
      }).toList();

      // Update Firestore
      final result = await updateTodo(event.todo);
      result.fold(
            (failure) => emit(TodoError(message: failure.message)),
            (_) => emit(TodoLoaded(todos: _sortTodos(updatedTodos))),
      );
    } else {
      emit(TodoLoading());
      final result = await updateTodo(event.todo);
      result.fold(
            (failure) => emit(TodoError(message: failure.message)),
            (_) => add(LoadTodosEvent()),
      );
    }
  }

  Future<void> _onDeleteTodos(DeleteTodoEvent event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      final currentTodos = (state as TodoLoaded).todos;
      final updatedTodos = currentTodos.where((todo) => todo.id != event.id).toList();

      // Delete from Firestore
      final result = await deleteTodo(event.id);
      result.fold(
            (failure) => emit(TodoError(message: failure.message)),
            (_) => emit(TodoLoaded(todos: _sortTodos(updatedTodos))),
      );
    } else {
      emit(TodoLoading());
      final result = await deleteTodo(event.id);
      result.fold(
            (failure) => emit(TodoError(message: failure.message)),
            (_) => add(LoadTodosEvent()),
      );
    }
  }

  Future<void> _onSearchTodos(SearchTodoEvent event, Emitter<TodoState> emit) async {
    _debounce?.cancel();
    if (event.query.isEmpty) {
      add(LoadTodosEvent());
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      add(SearchTodoEvent(event.query));
    });

    emit(TodoLoading());
    final result = await searchTodos(event.query);
    result.fold(
          (failure) => emit(TodoError(message: failure.message)),
          (todos) => emit(TodoLoaded(todos: _sortTodos(todos))),
    );
    _debounce?.cancel();
  }

  // Sorting logic: Incomplete tasks sorted by dueDate, then completed tasks
  List<Todo> _sortTodos(List<Todo> todos) {
    final incomplete = todos.where((todo) => !todo.isComplete).toList()
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
    final complete = todos.where((todo) => todo.isComplete).toList()
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
    return [...incomplete, ...complete];
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}