import 'package:hive_flutter/adapters.dart';
part 'why_list_adapter.g.dart';

@HiveType(typeId: 3)
class WhyList {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;

  WhyList({
    required this.title,
    required this.description,
  });
}
