
import 'package:flutter/material.dart';
import '../data/models/task.dart';
import '../repository/task_repository.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskRepository repository;
  List<Task> tasks = [];

  TaskViewModel({required this.repository});

  Future<void> loadTasks() async {
    tasks = await repository.fetchTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await repository.addTask(task);
    await loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await repository.updateTask(task);
    await loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await repository.deleteTask(id);
    await loadTasks();
  }
}