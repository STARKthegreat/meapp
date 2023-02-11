import 'package:hive/hive.dart';
part 'goal_storage.g.dart';

@HiveType(typeId: 1)
class GoalStorage extends HiveObject {
  GoalStorage(
      {required this.title,
      required this.deadline,
      required this.description,
      this.subGoal = const []});
  @HiveField(0)
  String title = '';
  @HiveField(1)
  String description = '';
  @HiveField(2)
  DateTime deadline;
  @HiveField(3)
  List<GoalStorage> subGoal;
}
