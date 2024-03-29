// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notif_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotifModelAdapter extends TypeAdapter<NotifModel> {
  @override
  final int typeId = 0;

  @override
  NotifModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotifModel(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as int?,
      fields[4] as int?,
      fields[5] as int?,
      fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, NotifModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.dec)
      ..writeByte(3)
      ..write(obj.hour)
      ..writeByte(4)
      ..write(obj.minute)
      ..writeByte(5)
      ..write(obj.second)
      ..writeByte(6)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotifModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
