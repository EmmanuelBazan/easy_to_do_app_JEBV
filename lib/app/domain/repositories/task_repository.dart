import 'package:easy_to_do_app/app/domain/models/task_model.dart';

abstract class TaskRepository {
  Future<List<TaskModel>> getTaskList();
  Future<TaskModel?> createTask(TaskModel task);
  Future<TaskModel?> checkTask(TaskModel task);
}
