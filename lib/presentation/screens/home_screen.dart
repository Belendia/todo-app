import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login to Todo App')),
      body: Column(
        children: [
          const TextField(
            decoration: InputDecoration(labelText: 'Username'),
          ),
          const TextField(
              decoration: InputDecoration(labelText: 'Passsword'),
              obscureText: true),
          ElevatedButton(onPressed: () {}, child: const Text('LOGIN'))
        ],
      ),
    );
  }
}
