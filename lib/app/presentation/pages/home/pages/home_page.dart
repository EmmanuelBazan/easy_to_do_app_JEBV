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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Sin tareas por el momento',
            ),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (_, index) =>
                  Text(homeController.taskList[index].title),
              separatorBuilder: (_, __) => Container(),
              itemCount: homeController.taskList.length,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
