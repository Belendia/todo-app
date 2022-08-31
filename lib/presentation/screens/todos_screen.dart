import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/logic/bloc/todos/todos_bloc.dart';
import 'package:todo_app/presentation/widgets/create_new_task.dart';

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
                children: [
                  ...state.tasks.map(
                    (e) => ListTile(
                      title: Text(e.task),
                      trailing: Checkbox(
                        value: e.completed,
                        onChanged: (val) {
                          BlocProvider.of<TodosBloc>(context)
                              .add(ToogleTodoEvent(e.task));
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('Create new task'),
                    trailing: const Icon(Icons.add),
                    onTap: () async {
                      final result = showDialog<String>(
                        context: context,
                        builder: (context) =>
                            const Dialog(child: CreateNewTask()),
                      ).then((result) => {
                            if (result != null)
                              {
                                BlocProvider.of<TodosBloc>(context)
                                    .add(AddTodoEvent(result))
                              }
                          });
                    },
                  )
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
