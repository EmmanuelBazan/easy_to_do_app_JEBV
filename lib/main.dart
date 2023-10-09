import 'package:easy_to_do_app/app/data/repositories_implementations/task_repository_impl.dart';
import 'package:easy_to_do_app/app/domain/repositories/task_repository.dart';
import 'package:easy_to_do_app/app/presentation/pages/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/my_app.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider<TaskRepository>(create: (_) => TaskRepositoryImpl()),
      ChangeNotifierProvider<HomeController>(
          create: (context) => HomeController(context.read())),
    ],
    child: const MyApp(),
  ));
}
