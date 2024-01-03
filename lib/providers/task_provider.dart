import 'package:flutter/material.dart';
import 'package:my_goals/features/models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  List<Task>? _tasks;
  List<Task>? get tasks => _tasks;
  set tasks(List<Task>? tasks) {
    _tasks = tasks;
    notifyListeners();
  }
}
