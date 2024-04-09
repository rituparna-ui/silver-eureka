import 'package:flutter/material.dart';
import 'package:todos_value_notifier/models/todo.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({
    super.key,
  });

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void addTodo() {
    final todo = Todo(title: _controller.text);
    Navigator.of(context).pop(todo);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Todo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(null),
        ),
        TextButton(
          onPressed: addTodo,
          child: const Text('Add'),
        ),
      ],
    );
  }
}
