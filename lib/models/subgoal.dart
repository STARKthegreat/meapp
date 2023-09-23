import 'package:hive/hive.dart';
part 'subgoal.g.dart';

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
