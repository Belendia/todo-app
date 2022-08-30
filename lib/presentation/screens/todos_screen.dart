import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/logic/bloc/todos/todos_bloc.dart';

import '../../data/services/todo.dart';

class TodosScreen extends StatelessWidget {
  final String username;

  const TodosScreen({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TodosBloc(RepositoryProvider.of<TodoService>(context))
            ..add(LoadTodosEvent(username)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Todo list')),
        body: BlocBuilder<TodosBloc, TodosState>(
          builder: (context, state) {
            if (state is TodosLoadedState) {
              return ListView(
                children: state.tasks
                    .map(
                      (e) => ListTile(
                        title: Text(e.task),
                        trailing:
                            Checkbox(value: e.completed, onChanged: (val) {}),
                      ),
                    )
                    .toList(),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
