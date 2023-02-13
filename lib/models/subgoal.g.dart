// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subgoal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubGoalAdapter extends TypeAdapter<SubGoal> {
  @override
  final int typeId = 2;

  @override
  SubGoal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubGoal(
      title: fields[0] as String,
      description: fields[1] as String,
      deadline: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, SubGoal obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.deadline);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubGoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}