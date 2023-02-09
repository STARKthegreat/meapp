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
  final _box2Name = 'mySubGoals';

  //Fetch Tasks
  fetchTask() async {
    Box<GoalStorage> box = await Hive.openBox(_box1Name);
    myGoals = box.values.toList().reversed.toList();
    myGoals.reversed;
    notifyListeners();
  }

  //Store new task
  storeGoals(
      {required String description,
      required String title,
      required DateTime deadline}) async {
    Box<GoalStorage> box = await Hive.openBox(_box1Name);
    box.add(GoalStorage(
        title: title, deadline: deadline, description: description));
    myGoals = box.values.toList();
    notifyListeners();
  }

//fetch subGoals
  fetchSubTask() async {
    Box<GoalStorage> box = await Hive.openBox(_box2Name);
    mySubGoals = box.values.toList().reversed.toList();
    notifyListeners();
  }

  storeSubGoals(
      {required String description,
      required String title,
      required DateTime deadline}) async {
    Box<GoalStorage> box = await Hive.openBox(_box2Name);
    box.add(GoalStorage(
        title: title, deadline: deadline, description: description));
    mySubGoals = box.values.toList().reversed.toList();
    notifyListeners();
  }
}
