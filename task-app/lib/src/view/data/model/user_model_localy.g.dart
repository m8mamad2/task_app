// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model_localy.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelLocalyAdapter extends TypeAdapter<UserModelLocaly> {
  @override
  final int typeId = 1;

  @override
  UserModelLocaly read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModelLocaly(
      name: fields[0] as String?,
      email: fields[1] as String?,
      profileImage: fields[3] as int?,
      token: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModelLocaly obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.token)
      ..writeByte(3)
      ..write(obj.profileImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelLocalyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
