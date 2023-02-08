import 'package:hive/hive.dart';
part 'goal_storage.g.dart';

@HiveType(typeId: 1)
class GoalStorage extends HiveObject {
  GoalStorage(this.title, this.deadline, this.description);
  @HiveField(0)
  String title = '';
  @HiveField(1)
  String description = '';
  @HiveField(2)
  DateTime deadline = DateTime(2023);
}
