//Store the task
//Update task
//Check and uncheck task
import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {
  List myTaskTitle = [];
  List myTaskDescription = [];
  List myDeadline = [];
  //Store new task
  store() {
    notifyListeners();
  }
}
