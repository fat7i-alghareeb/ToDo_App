// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dated_tasks.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DatedTasksAdapter extends TypeAdapter<DatedTasks> {
  @override
  final int typeId = 1;

  @override
  DatedTasks read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    // Add logic to read the 'date' and 'tasks' fields
    return DatedTasks(
      date: fields[0] as String,
      tasks: (fields[1] as List<dynamic>).cast<Tasks>(),
    );
  }

  @override
  void write(BinaryWriter writer, DatedTasks obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.tasks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DatedTasksAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
