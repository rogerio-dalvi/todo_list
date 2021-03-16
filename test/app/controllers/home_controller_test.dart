import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/app/controllers/home_controller.dart';
import 'package:todo_list/app/models/todo_model.dart';
import 'package:todo_list/app/repositories/todo_repository.dart';

class TodoRepositoryMock extends Mock implements TodoRepository {}

main() {
  final repository = TodoRepositoryMock();
  HomeController controller = HomeController(repository);

  test('deve preencher variavel todos', () async {
    when(repository.fetchTodos()).thenAnswer((_) async => [TodoModel()]);

    expect(controller.state, HomeState.start);
    await controller.start();
    expect(controller.state, HomeState.success);
    expect(controller.todos.isNotEmpty, true);
  });

  test('deve modificar o estado para error se a requisição falhar', () async {
    controller = HomeController(repository);
    when(repository.fetchTodos()).thenThrow(Exception());

    expect(controller.state, HomeState.start);
    await controller.start();
    expect(controller.state, HomeState.error);
  });
}
