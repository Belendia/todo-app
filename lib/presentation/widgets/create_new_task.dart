import 'package:flutter/material.dart';

class CreateNewTask extends StatefulWidget {
  const CreateNewTask({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateNewTaskState();
}

class _CreateNewTaskState extends State<CreateNewTask> {
  final _inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("What task to you want to create"),
        TextField(controller: _inputController),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(_inputController.text);
          },
          child: const Text('SAVE'),
        )
      ],
    );
  }
}
