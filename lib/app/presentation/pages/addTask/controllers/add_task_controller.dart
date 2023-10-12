import 'package:easy_to_do_app/app/domain/models/task_model.dart';
import 'package:easy_to_do_app/app/domain/repositories/task_repository.dart';
import 'package:flutter/material.dart';

class AddTaskController extends ChangeNotifier {
  final TaskRepository taskRepository;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String titleInput = '';
  String descriptionInput = '';

  bool _isLoading = false;
  bool _mounted = true;

  AddTaskController(this.taskRepository);

  bool get isLoading => _isLoading;
  bool get mounted => _mounted;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Future<TaskModel?> createTask() async {
    final task = TaskModel(
      id: null,
      title: titleInput,
      description: descriptionInput,
      done: false,
      priority: '',
      creationDate: '',
      images: null,
    );

    final res = await taskRepository.createTask(task);

    return res;
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
