// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'why_list_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WhyListAdapter extends TypeAdapter<WhyList> {
  @override
  final int typeId = 3;

  @override
  WhyList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WhyList(
      title: fields[0] as String,
      description: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WhyList obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WhyListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
