import 'package:easy_to_do_app/app/presentation/navigation/routes.dart';
import 'package:easy_to_do_app/app/presentation/pages/home/controllers/home_controller.dart';
import 'package:easy_to_do_app/app/presentation/pages/home/widgets/task_card.dart';
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
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_left_outlined)),
              TextButton(
                  onPressed: () {}, child: Text(homeController.dateDisplay)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_right_outlined)),
            ],
          )
        ],
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
                  task: currentTask,
                  check: homeController.checkTask,
                );
              },
              separatorBuilder: (_, __) => Container(),
              itemCount: homeController.taskList.length,
            ),
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
