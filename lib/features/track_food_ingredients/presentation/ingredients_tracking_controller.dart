import 'dart:async';

import 'package:engaige_assessment/features/track_food_ingredients/data/ingredient_tracking_repository.dart';
import 'package:engaige_assessment/features/track_food_ingredients/domain/MacroEntry.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

part 'ingredients_tracking_controller.g.dart';

@HiveType(typeId: 1)
enum MealType {
  @HiveField(0)
  breakfast,
  @HiveField(1)
  lunch,
  @HiveField(2)
  dinner,
  @HiveField(3)
  snack
}

@HiveType(typeId: 2)
enum MacroType {
  @HiveField(0)
  sugar,
  @HiveField(1)
  fat
}

@HiveType(typeId: 3)
enum MacroLevel {
  @HiveField(0)
  low,
  @HiveField(1)
  medium,
  @HiveField(2)
  high
}

class IngredientsTrackingController extends GetxController {
  IngredientTrackingRepository repository = IngredientTrackingRepository();

  Rxn<Map<MealType, List<MacroEntry>>> initialMeals = Rxn();
  Rxn<Map<MealType, List<MacroEntry>>> meals = Rxn();

  Rxn<MacroLevel> currentlySelectedFatLevel = Rxn<MacroLevel>();
  Rxn<MacroLevel> currentlySelectedSugarLevel = Rxn<MacroLevel>();

  // to check whether something has changed relative to the start of the editing process
  RxBool somethingHasChanged = false.obs;
  RxBool allFilledOut = false.obs;

  late StreamSubscription changeSubscription;
  late StreamSubscription allFilledOutSubscription;

  @override
  void onInit() {
    changeSubscription = meals.listen((data) {
      somethingHasChanged.value = !mapEquals(data, initialMeals.value);
    });

    allFilledOutSubscription = meals.listen((data) {
      if (data != null) {
        List<MealType> keys = data.keys.toList();

        // if there is data for all of the meal types, the progress bar is continuous
        if (keys.contains(MealType.breakfast) &&
            keys.contains(MealType.lunch) &&
            keys.contains(MealType.dinner) &&
            keys.contains(MealType.snack)) {
          allFilledOut.value = true;
        }
      }
    });

    loadStoredData();

    super.onInit();
  }

  @override
  void onClose() {
    changeSubscription.cancel();
    allFilledOutSubscription.cancel();

    super.onClose();
  }

  clearCurrentlySelected() {
    currentlySelectedFatLevel.value = null;
    currentlySelectedSugarLevel.value = null;
  }

  storeData() {
    repository.storeData(meals: meals.value!);
  }

  loadStoredData() {
    var record = repository.loadStoredData();

    if (record.breakfast != null &&
        record.lunch != null &&
        record.dinner != null &&
        record.snack != null) {
      initialMeals.value = {
        if (record.breakfast != null) MealType.breakfast: record.breakfast!,
        if (record.lunch != null) MealType.lunch: record.lunch!,
        if (record.dinner != null) MealType.dinner: record.dinner!,
        if (record.snack != null) MealType.snack: record.snack!,
      };

      meals.value = {
        if (record.breakfast != null) MealType.breakfast: record.breakfast!,
        if (record.lunch != null) MealType.lunch: record.lunch!,
        if (record.dinner != null) MealType.dinner: record.dinner!,
        if (record.snack != null) MealType.snack: record.snack!,
      };
    } else {
      initialMeals.value = {};
      meals.value = {};
    }
  }
}
