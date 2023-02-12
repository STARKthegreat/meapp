import 'package:hive/hive.dart';
part 'goal_storage.g.dart';

@HiveType(typeId: 1)
class GoalStorage extends HiveObject {
  GoalStorage({
    required this.title,
    required this.deadline,
    required this.description,
  });
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  DateTime deadline;
}

@HiveType(typeId: 2)
class SubGoal {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(3)
  DateTime deadline;

  SubGoal(
      {required this.title, required this.description, required this.deadline});
}
