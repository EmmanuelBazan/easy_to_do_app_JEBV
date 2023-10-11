import 'package:easy_to_do_app/app/presentation/pages/addTask/controllers/add_task_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddTaskController(),
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
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Titulo'),
                ),
                onChanged: (value) => controller.titleInput,
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
                onChanged: (value) => controller.descriptionInput,
                validator: (value) {
                  return (value != null && value.isNotEmpty)
                      ? null
                      : 'Ingresar una descripcion valida';
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controller.validateForm()) {
            print('FORMULARIO CORRECTO');
          } else {
            print('FORMULARIO INCORRECTO');
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
