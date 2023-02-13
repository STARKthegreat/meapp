//Store the task
//Update task
//Check and uncheck task
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meapp/models/goal_storage.dart';
import 'package:meapp/models/subgoal.dart';

class TaskProvider extends ChangeNotifier {
  List<GoalStorage> myGoals = [];
  List<SubGoal> mySubGoals = [];
  final _box1Name = 'myGoals';
  final _box2Name = 'mySubgoals';
//try adding another box for subgoals

  //Fetch Tasks
  fetchTask() async {
    Box<GoalStorage> box = await Hive.openBox<GoalStorage>(_box1Name);
    myGoals = box.values.toList().reversed.toList();
    print(box.keys);
    notifyListeners();
  }

  fetchSubtask() async {
    mySubGoals;
    notifyListeners();
  }

  //Store subtaks
  storeSubGoals(
      {required String description,
      required String title,
      required DateTime deadline}) async {
    Box<SubGoal> box = await Hive.openBox(_box2Name);
    box.add(
        SubGoal(title: title, description: description, deadline: deadline));
    mySubGoals = box.values.toList();
    notifyListeners();
  }

  //Store new task
  storeGoals(
      {required String description,
      required String title,
      required DateTime deadline}) async {
    Box<GoalStorage> box = await Hive.openBox(_box1Name);
    box.add(
      GoalStorage(
        title: title,
        deadline: deadline,
        description: description,
      ),
    );
    myGoals = box.values.toList();
    notifyListeners();
  }

  void deleteGoal() async {
    Box<GoalStorage> box = await Hive.openBox(_box1Name);
    box.clear();
    notifyListeners();
  }
}
