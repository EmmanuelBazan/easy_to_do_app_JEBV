import 'package:easy_to_do_app/app/domain/models/task_model.dart';
import 'package:easy_to_do_app/app/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  @override
  Future<List<TaskModel>> getTaskList() {
    final task = TaskModel(
      id: 1,
      title: 'titulo tarea 1',
      description: 'descripcion 1',
      done: false,
      priority: 'alta',
      creationDate: '13/13/13',
      images: null,
    );

    final task2 = TaskModel(
      id: 1,
      title: 'titulo tarea 1',
      description: 'descripcion 1',
      done: false,
      priority: 'alta',
      creationDate: '13/13/13',
      images: null,
    );

    final task3 = TaskModel(
      id: 1,
      title: 'titulo tarea 1',
      description: 'descripcion 1',
      done: false,
      priority: 'alta',
      creationDate: '13/13/13',
      images: null,
    );

    return Future.value([task, task2, task3]);
  }
}
