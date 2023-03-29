// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messier_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessierModelAdapter extends TypeAdapter<MessierModel> {
  @override
  final int typeId = 0;

  @override
  MessierModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessierModel(
      id: fields[0] as int?,
      messier: fields[1] as String?,
      ngc: fields[2] as String?,
      ra: fields[3] as String?,
      dec: fields[4] as String?,
      sec: fields[5] as String?,
      constellation: fields[6] as String?,
      magnitude: fields[7] as String?,
      description: fields[8] as String?,
      observed: fields[9] as bool?,
      queued: fields[10] as bool?,
      visible: fields[11] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, MessierModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.messier)
      ..writeByte(2)
      ..write(obj.ngc)
      ..writeByte(3)
      ..write(obj.ra)
      ..writeByte(4)
      ..write(obj.dec)
      ..writeByte(5)
      ..write(obj.sec)
      ..writeByte(6)
      ..write(obj.constellation)
      ..writeByte(7)
      ..write(obj.magnitude)
      ..writeByte(8)
      ..write(obj.description)
      ..writeByte(9)
      ..write(obj.observed)
      ..writeByte(10)
      ..write(obj.queued)
      ..writeByte(11)
      ..write(obj.visible);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessierModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
