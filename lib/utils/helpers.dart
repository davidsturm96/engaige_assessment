import '../features/track_food_ingredients/presentation/ingredients_tracking_controller.dart';

class Helpers {
  static String getMealTypeString({required MealType mealType}) {
    switch (mealType) {
      case MealType.breakfast:
        return 'Frühstück';
      case MealType.lunch:
        return 'Mittagessen';
      case MealType.dinner:
        return 'Abendessen';
      case MealType.snack:
        return 'Snack';
    }
  }

  static String getMacroLevelString({required MacroLevel macroLevel}) {
    switch (macroLevel) {
      case MacroLevel.low:
        return 'Niedrig';
      case MacroLevel.medium:
        return 'Mittel';
      case MacroLevel.high:
        return 'Hoch';
    }
  }
}
