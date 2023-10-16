import 'package:easy_to_do_app/app/domain/models/task_model.dart';
import 'package:flutter/material.dart';

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
          builder: (context) => AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(widget.task.title),
                    Text(widget.task.description),
                    Text(widget.task.creationDate),
                    Text(widget.task.priority),
                    Text(widget.task.images != null
                        ? '(imagenes)'
                        : 'sin imagenes'),
                  ],
                ),
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
                  value: isDone,
                  onChanged: (value) async {
                    widget.task.done = value;
                    final res = await widget.check(widget.task);
                    if (res != null) {
                      setState(() {
                        isDone = value;
                      });
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
