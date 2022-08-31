import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/services/todo.dart';

import '../../data/services/authentication.dart';
import '../../logic/bloc/home/home_bloc.dart';
import 'todos_screen.dart';

class HomeScreen extends StatelessWidget {
  final usernameField = TextEditingController();
  final passwordField = TextEditingController();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login to Todo App')),
      body: BlocProvider(
        create: (context) => HomeBloc(
            RepositoryProvider.of<AuthenticationService>(context),
            RepositoryProvider.of<TodoService>(context))
          ..add(RegisterServiceEvent()),
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is SuccessfulLoginState) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TodosScreen(username: state.username),
                ),
              );
            }

            if (state is HomeInitial) {
              if (state.error != null) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      title: const Text('Error'), content: Text(state.error!)),
                );
              }
            }
          },
          builder: (context, state) {
            if (state is HomeInitial) {
              return Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: 'Username'),
                    controller: usernameField,
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Passsword'),
                    obscureText: true,
                    controller: passwordField,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<HomeBloc>(context).add(LoginEvent(
                              usernameField.text, passwordField.text));
                        },
                        child: const Text('LOGIN'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<HomeBloc>(context).add(
                                RegisterAccountEvent(
                                    usernameField.text, passwordField.text));
                          },
                          child: const Text('REGISTER'),
                        ),
                      ),
                    ],
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
