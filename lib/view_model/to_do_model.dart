//Store the task
//Update task
//Check and uncheck task
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meapp/models/goal_storage.dart';

class TaskProvider extends ChangeNotifier {
  List myTaskTitle = [];
  List myTaskDescription = [];
  List myDeadline = [];

  //Store new task
  store() async {
    final myGoals = await Hive.openBox('myGoals');
    myGoals.add(myDeadline);
    notifyListeners();
  }
}
