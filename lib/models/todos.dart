import 'package:flutter/material.dart';
import 'package:todos_value_notifier/models/todo.dart';

class Todos extends ValueNotifier<List<Todo>> {
  Todos._singleton()
      : super([
          Todo(title: 'hehe1'),
          Todo(title: 'hehe2'),
          Todo(title: 'hehe3'),
        ]);
  static final Todos _shared = Todos._singleton();

  factory Todos() {
    return _shared;
  }

  int get length => value.length;

  void add({required Todo todo}) {
    value.add(todo);
    notifyListeners();
  }

  void remove({required Todo todo}) {
    value.remove(todo);
    notifyListeners();
  }

  void toggle({required Todo todo}) {
    todo.isDone = !todo.isDone;
    notifyListeners();
  }

  Todo? todo({required int indexAt}) {
    if (indexAt < 0 || indexAt >= value.length) {
      return null;
    }
    return value[indexAt];
  }
}
