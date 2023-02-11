//Store the task
//Update task
//Check and uncheck task
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meapp/models/goal_storage.dart';

class TaskProvider extends ChangeNotifier {
  List<GoalStorage> myGoals = [];
  List<GoalStorage> mySubGoals = [];
  final _box1Name = 'myGoals';

  //Fetch Tasks
  fetchTask() async {
    Box<GoalStorage> box = await Hive.openBox(_box1Name);
    myGoals = box.values.toList().reversed.toList();
    notifyListeners();
  }

  //Store subtaks
  storeSubGoals(
      {required String description,
      required String title,
      required DateTime deadline}) {
    mySubGoals.add(GoalStorage(
        title: title, deadline: deadline, description: description));
    notifyListeners();
  }

  //Store new task
  storeGoals(
      {required String description,
      required String title,
      required DateTime deadline}) async {
    Box<GoalStorage> box = await Hive.openBox(_box1Name);
    box.add(GoalStorage(
        title: title,
        deadline: deadline,
        description: description,
        subGoal: mySubGoals));
    myGoals = box.values.toList();
    notifyListeners();
  }
}
