import 'package:flutter/material.dart';

class AddTaskController extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String titleInput = '';
  String descriptionInput = '';

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool validateForm() {
    print('$titleInput $descriptionInput');
    return formKey.currentState?.validate() ?? false;
  }
}
