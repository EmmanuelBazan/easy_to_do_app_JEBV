import 'package:easy_to_do_app/app/domain/models/task_model.dart';
import 'package:easy_to_do_app/app/presentation/pages/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef CheckFuntion = Future<TaskModel?> Function(TaskModel);

class TaskCard extends StatefulWidget {
  final TaskModel task;
  final CheckFuntion check;

  const TaskCard({
    super.key,
    required this.task,
    required this.check,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool isDone = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isDone = widget.task.done;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(0),
      onPressed: () => showDialog(
          context: context,
          builder: (context) => PreviewTask(
                task: widget.task,
              )),
      child: Card(
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.only(left: 15),
          alignment: Alignment.centerLeft,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.task.title),
              Switch(
                  value: widget.task.done,
                  onChanged: (value) async {
                    widget.task.done = value;
                    final res = await widget.check(widget.task);
                    if (res != null) {
                      setState(() {});
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class PreviewTask extends StatelessWidget {
  final TaskModel task;

  const PreviewTask({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Provider.of(context);

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(task.title),
          Text(task.description),
          Text(task.creationDate),
          Text(task.priority),
          Text(task.images != null ? '(imagenes)' : 'sin imagenes'),
          TextButton(
              onPressed: () async {
                await controller.deleteTask(task.id!);

                if (controller.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Eliminar',
                style: TextStyle(color: Colors.red),
              ))
        ],
      ),
    );
  }
}
