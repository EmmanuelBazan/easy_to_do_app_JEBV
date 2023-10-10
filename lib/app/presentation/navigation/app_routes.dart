import 'package:easy_to_do_app/app/presentation/navigation/routes.dart';
import 'package:easy_to_do_app/app/presentation/pages/pages.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.homePage: (_) => const HomePage(title: 'Isitudu'),
    Routes.addTaskPage: (_) => const AddTaskPage()
  };
}
