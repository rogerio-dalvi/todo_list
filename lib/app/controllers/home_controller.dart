import 'package:flutter/cupertino.dart';
import 'package:todo_list/app/models/todo_model.dart';
import 'package:todo_list/app/repositories/todo_repository.dart';

class HomeController {
  List<TodoModel> todos = [];
  // HomeState state = HomeState.start;
  final TodoRepository _repository;
  final state = ValueNotifier<HomeState>(HomeState.start);

  HomeController([TodoRepository repository])
      : _repository = repository ?? TodoRepository();

  Future start() async {
    state.value = HomeState.loading;
    try {
      todos = await _repository.fetchTodos();
      state.value = HomeState.success;
    } on Exception catch (e) {
      state.value = HomeState.error;
    }
  }
}

enum HomeState {
  start,
  loading,
  success,
  error,
}
