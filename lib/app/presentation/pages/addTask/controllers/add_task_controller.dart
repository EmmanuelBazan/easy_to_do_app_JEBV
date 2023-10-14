import 'package:easy_to_do_app/app/domain/models/task_model.dart';
import 'package:easy_to_do_app/app/domain/repositories/task_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskController extends ChangeNotifier {
  final TaskRepository taskRepository;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String titleInput = '';
  String descriptionInput = '';
  String dateInput = '';

  bool _isLoading = false;
  bool _mounted = true;

  bool get isLoading => _isLoading;
  bool get mounted => _mounted;

  DateTime _selectedDate = DateTime.now();

  AddTaskController(this.taskRepository) {
    init();
  }

  void init() {
    _setCurrentDate(_selectedDate);
  }

  void _setCurrentDate(DateTime now) {
    var formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    dateInput = formattedDate;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Future<TaskModel?> createTask() async {
    final task = TaskModel(
      id: null,
      title: titleInput,
      description: descriptionInput,
      done: false,
      priority: '',
      creationDate: '',
      images: null,
    );

    final res = await taskRepository.createTask(task);

    return res;
  }

  Future<DateTime?> selectCurrentDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      _setCurrentDate(picked);
    }

    return picked;
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
