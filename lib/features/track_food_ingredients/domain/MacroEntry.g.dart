// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MacroEntry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MacroEntryAdapter extends TypeAdapter<MacroEntry> {
  @override
  final int typeId = 4;

  @override
  MacroEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MacroEntry(
      macroType: fields[1] as MacroType,
      macroLevel: fields[0] as MacroLevel,
    );
  }

  @override
  void write(BinaryWriter writer, MacroEntry obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.macroLevel)
      ..writeByte(1)
      ..write(obj.macroType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MacroEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
