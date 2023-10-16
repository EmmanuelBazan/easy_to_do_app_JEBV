import 'package:easy_to_do_app/app/data/repositories_implementations/task_repository_impl.dart';
import 'package:easy_to_do_app/app/data/services/local/sqlite_db.dart';
import 'package:easy_to_do_app/app/presentation/pages/addTask/controllers/add_task_controller.dart';
import 'package:easy_to_do_app/app/presentation/pages/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddTaskController(
        TaskRepositoryImpl(
          SqliteDB(),
        ),
      ),
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AddTaskController controller = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar tarea'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  label: Text('Titulo'),
                ),
                onChanged: (value) => controller.titleInput = value,
                validator: (value) {
                  return (value != null && value.isNotEmpty)
                      ? null
                      : 'Ingresar un titulo valido';
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Descripcion'),
                ),
                onChanged: (value) => controller.descriptionInput = value,
              ),
              _scheduleSection(controller, context),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (controller.validateForm()) {
            final res = await controller.createTask();
            if (res != null) {
              if (controller.mounted) {
                Navigator.pop(context);
                await Provider.of<HomeController>(context, listen: false)
                    .addTask(res);
              }
            }
          } else {
            print('FORMULARIO INCORRECTO');
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  Column _scheduleSection(AddTaskController controller, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Programar'),
        // RadioListTile(
        //   value: 1,
        //   groupValue: 1,
        //   onChanged: (value) {},
        //   title: const Text('Tarea diaria'),
        // ),
        TextButton(
          onPressed: () async {
            await controller.selectCurrentDate(context);
          },
          child: Text(controller.dateInput),
        )
      ],
    );
  }
}
