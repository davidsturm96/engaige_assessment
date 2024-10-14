import 'package:engaige_assessment/features/track_food_ingredients/presentation/ingredients_tracking_controller.dart';
import 'package:hive/hive.dart';

part 'MacroEntry.g.dart';

@HiveType(typeId: 4)
class MacroEntry {
  @HiveField(0)
  final MacroLevel macroLevel;
  @HiveField(1)
  final MacroType macroType;

  const MacroEntry({required this.macroType, required this.macroLevel});

  factory MacroEntry.fromJson(Map<String, dynamic> json) => MacroEntry(
        macroType: MacroType.values.firstWhere(
          (e) => e.toString() == 'MacroType.${json['type']}',
        ),
        macroLevel: MacroLevel.values.firstWhere(
          (e) => e.toString() == 'MacroLevel.${json['level']}',
        ),
      );

  Map<String, dynamic> toJson() => {
        'type': macroType.name,
        'level': macroLevel.name,
      };
}

class Bee {
  Bee({required this.name, required this.role});

  factory Bee.fromJson(Map<String, dynamic> json) => Bee(
        name: json['name'] as String,
        role: json['role'] as String,
      );

  final String name;
  final String role;

  Map<String, dynamic> toJson() => {
        'name': name,
        'role': role,
      };
}
