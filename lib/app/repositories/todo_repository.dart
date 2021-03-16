import 'package:dio/dio.dart';
import 'package:todo_list/app/models/todo_model.dart';

class TodoRepository {
  Dio dio;
  final url = 'https://jsonplaceholder.typicode.com/todos';

  TodoRepository([Dio client]) {
    dio = client ?? new Dio();
  }

  Future<List<TodoModel>> fetchTodos() async {
    final response = await dio.get(url);
    final list = response.data as List;

    List<TodoModel> todos =
        list.map((json) => TodoModel.fromJson(json)).toList();

    // Antigo código para lembrar.
    // List<TodoModel> todos = [];
    // for (var json in list) {
    //   todos.add(TodoModel.fromJson(json));
    // }

    return todos;
  }
}
