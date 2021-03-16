import 'package:flutter/material.dart';
import 'package:todo_list/app/controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Todo\'s'),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh_outlined),
              onPressed: () => controller.start()),
          IconButton(
            icon: Icon(Icons.error_outlined),
            onPressed: () => controller.state.value = HomeState.error,
          )
        ],
      ),
      body: AnimatedBuilder(
        animation: controller.state,
        builder: (BuildContext context, Widget child) {
          return stateManagement(controller.state.value);
        },
      ),
    );
  }

  void initState() {
    super.initState();

    controller.start();
    // controller.state.value = HomeState.error;
  }

  stateManagement(HomeState state) {
    switch (state) {
      case HomeState.start:
        return _start();
      case HomeState.loading:
        return _loading();
      case HomeState.success:
        return _success();
      case HomeState.error:
        return _error();
      default:
        return _start();
    }
  }

  _success() {
    return ListView.builder(
      itemCount: controller.todos.length,
      itemBuilder: (context, index) {
        var todo = controller.todos[index];

        return ListTile(
          leading: Checkbox(
            value: todo.completed,
            onChanged: (bool value) {},
          ),
          title: Text(todo.title),
        );
      },
    );
  }

  _error() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Ocorreu um erro:'),
          RaisedButton(
            onPressed: () {
              controller.start();
            },
            child: Text('Tentar novamente'),
          ),
        ],
      ),
    );
  }

  _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _start() {
    return Container();
  }
}
