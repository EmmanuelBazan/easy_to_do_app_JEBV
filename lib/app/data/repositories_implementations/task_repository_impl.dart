import 'package:easy_to_do_app/app/data/services/local/sqlite_db.dart';
import 'package:easy_to_do_app/app/domain/models/task_model.dart';
import 'package:easy_to_do_app/app/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final SqliteDB sqliteDB;

  TaskRepositoryImpl(this.sqliteDB);

  @override
  Future<List<TaskModel>> getTaskList() async {
    final db = await sqliteDB.getDB;
    final res = await sqliteDB.getAllTasks(db);

    return res;
  }

  @override
  Future<TaskModel?> createTask(TaskModel task) async {
    final db = await sqliteDB.getDB;
    final res = await sqliteDB.createTask(db, task);

    return res;
  }

  @override
  Future<TaskModel?> checkTask(TaskModel task) async {
    final db = await sqliteDB.getDB;
    final res = await sqliteDB.updateTask(db, task);

    return res;
  }

  @override
  Future<int?> deleteTask(int taskId) async {
    final db = await sqliteDB.getDB;
    final res = await sqliteDB.deleteTask(db, taskId);

    return res;
  }

  @override
  Future<List<TaskModel>> getTaskByDate(String date) async {
    final db = await sqliteDB.getDB;
    final res = await sqliteDB.getTasksByDate(db, date);

    return res;
  }
}
