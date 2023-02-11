// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_storage.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoalStorageAdapter extends TypeAdapter<GoalStorage> {
  @override
  final int typeId = 1;

  @override
  GoalStorage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GoalStorage(
      title: fields[0] as String,
      deadline: fields[2] as DateTime,
      description: fields[1] as String,
      subGoal: (fields[3] as List).cast<GoalStorage>(),
    );
  }

  @override
  void write(BinaryWriter writer, GoalStorage obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.deadline)
      ..writeByte(3)
      ..write(obj.subGoal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalStorageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
