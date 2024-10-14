// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredients_tracking_controller.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MealTypeAdapter extends TypeAdapter<MealType> {
  @override
  final int typeId = 1;

  @override
  MealType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MealType.breakfast;
      case 1:
        return MealType.lunch;
      case 2:
        return MealType.dinner;
      case 3:
        return MealType.snack;
      default:
        return MealType.breakfast;
    }
  }

  @override
  void write(BinaryWriter writer, MealType obj) {
    switch (obj) {
      case MealType.breakfast:
        writer.writeByte(0);
        break;
      case MealType.lunch:
        writer.writeByte(1);
        break;
      case MealType.dinner:
        writer.writeByte(2);
        break;
      case MealType.snack:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MacroTypeAdapter extends TypeAdapter<MacroType> {
  @override
  final int typeId = 2;

  @override
  MacroType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MacroType.sugar;
      case 1:
        return MacroType.fat;
      default:
        return MacroType.sugar;
    }
  }

  @override
  void write(BinaryWriter writer, MacroType obj) {
    switch (obj) {
      case MacroType.sugar:
        writer.writeByte(0);
        break;
      case MacroType.fat:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MacroTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MacroLevelAdapter extends TypeAdapter<MacroLevel> {
  @override
  final int typeId = 3;

  @override
  MacroLevel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MacroLevel.low;
      case 1:
        return MacroLevel.medium;
      case 2:
        return MacroLevel.high;
      default:
        return MacroLevel.low;
    }
  }

  @override
  void write(BinaryWriter writer, MacroLevel obj) {
    switch (obj) {
      case MacroLevel.low:
        writer.writeByte(0);
        break;
      case MacroLevel.medium:
        writer.writeByte(1);
        break;
      case MacroLevel.high:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MacroLevelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
