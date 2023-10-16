import 'package:easy_to_do_app/app/domain/models/task_model.dart';
import 'package:easy_to_do_app/app/domain/repositories/task_repository.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  final TaskRepository taskRepository;

  List<TaskModel> taskList = [];

  bool _mounted = true;

  get mounted => _mounted;

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

  Future<void> deleteTask(int taskId) async {
    final res = await taskRepository.deleteTask(taskId);

    if (res != null) {
      final index = taskList.lastIndexWhere((element) => element.id == taskId);
      taskList.removeAt(index);
      notifyListeners();
    } else {}
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
