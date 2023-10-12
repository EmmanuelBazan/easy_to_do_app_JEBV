import 'package:easy_to_do_app/app/presentation/navigation/routes.dart';
import 'package:easy_to_do_app/app/presentation/pages/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await Provider.of<HomeController>(context, listen: false).getTaskList();
  }

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (_, index) {
                final currentTask = homeController.taskList[index];
                return TaskCard(
                  title: currentTask.title,
                  done: currentTask.done,
                );
              },
              separatorBuilder: (_, __) => Container(),
              itemCount: homeController.taskList.length,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.addTaskPage);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class TaskCard extends StatelessWidget {
  final String title;
  final bool done;

  const TaskCard({
    super.key,
    required this.title,
    required this.done,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.only(left: 15),
        alignment: Alignment.centerLeft,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Switch(value: done, onChanged: (value) {}),
          ],
        ),
      ),
    );
  }
}
