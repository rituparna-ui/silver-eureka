import 'package:flutter/material.dart';
import 'package:todos_value_notifier/models/todo.dart';
import 'package:todos_value_notifier/models/todos.dart';
import 'package:todos_value_notifier/new_todo.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos ft. Value Notifier'),
      ),
      body: ValueListenableBuilder(
        valueListenable: Todos(),
        builder: (context, value, child) {
          final todos = value;
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: ((context, index) {
              Todo todo = todos[index];
              return ListTile(
                title: Text(
                  todo.title,
                  style: TextStyle(
                    decoration: todo.isDone ? TextDecoration.lineThrough : null,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Checkbox(
                  value: todo.isDone,
                  onChanged: (val) {
                    Todos().toggle(todo: todo);
                  },
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                  onPressed: () async {
                    final delete = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Are you sure?'),
                          actions: [
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () => Navigator.of(context).pop(false),
                            ),
                            TextButton(
                              child: const Text('Delete'),
                              onPressed: () => Navigator.of(context).pop(true),
                            ),
                          ],
                        );
                      },
                    );
                    if (delete) {
                      Todos().remove(todo: todo);
                    }
                  },
                ),
              );
            }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Todo? todo = await showDialog(
            context: context,
            builder: (context) {
              return const NewTodo();
            },
          );
          if (todo != null) {
            final todos = Todos();
            todos.add(todo: todo);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
