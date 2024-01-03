import 'package:flutter/material.dart';
import 'package:my_goals/models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  List<Task>? _tasks;
  List<Task>? get tasks => _tasks;
  set tasks(List<Task>? tasks) {
    _tasks = tasks;
    notifyListeners();
  }

  void modify(String id, double amount) {
    int index = _tasks!.indexWhere((element) => element.id == id);
    _tasks![index].currentAmount += amount;
    notifyListeners();
  }
}
