import 'package:easy_to_do_app/app/domain/models/task_model.dart';
import 'package:easy_to_do_app/app/domain/repositories/task_repository.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  final TaskRepository taskRepository;

  List<TaskModel> taskList = [];

  HomeController(this.taskRepository);

  Future<void> getTaskList() async {
    taskList = await taskRepository.getTaskList();
    notifyListeners();
  }

  addTask(TaskModel task) async {
    taskList.add(task);
    notifyListeners();
  }

  Future<TaskModel?> checkTask(TaskModel task) async {
    final res = taskRepository.checkTask(task);
    return res;
  }
}
