import 'package:engaige_assessment/features/track_food_ingredients/domain/MacroEntry.dart';
import 'package:engaige_assessment/features/track_food_ingredients/presentation/ingredients_tracking_controller.dart';
import 'package:hive/hive.dart';

class IngredientTrackingRepository {
  final Box _box = Hive.box('myBox');

  storeData({required Map<MealType, List<MacroEntry>> meals}) {
    _box.put(MealType.breakfast.name, meals[MealType.breakfast]);
    _box.put(MealType.lunch.name, meals[MealType.lunch]);
    _box.put(MealType.dinner.name, meals[MealType.dinner]);
    _box.put(MealType.snack.name, meals[MealType.snack]);
  }

  ({
    List<MacroEntry>? breakfast,
    List<MacroEntry>? dinner,
    List<MacroEntry>? lunch,
    List<MacroEntry>? snack,
  }) loadStoredData() {
    List<MacroEntry>? breakfast =
        _box.get(MealType.breakfast.name)?.cast<MacroEntry>();
    List<MacroEntry>? lunch = _box.get(MealType.lunch.name)?.cast<MacroEntry>();
    List<MacroEntry>? dinner =
        _box.get(MealType.dinner.name)?.cast<MacroEntry>();
    List<MacroEntry>? snack = _box.get(MealType.snack.name)?.cast<MacroEntry>();

    return (breakfast: breakfast, lunch: lunch, dinner: dinner, snack: snack);
  }
}
