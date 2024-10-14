import 'package:engaige_assessment/constants/colors.dart';
import 'package:engaige_assessment/features/track_food_ingredients/presentation/ingredients_tracking_controller.dart';
import 'package:engaige_assessment/utils/helpers.dart';
import 'package:engaige_assessment/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../domain/MacroEntry.dart';

class InputModalBottomSheet extends StatelessWidget {
  final MealType mealType;

  const InputModalBottomSheet({super.key, required this.mealType});

  @override
  Widget build(BuildContext context) {
    IngredientsTrackingController controller = Get.find();

    return TapRegion(
      onTapOutside: (_) {
        controller.clearCurrentlySelected();
      },
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal * 5,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Fettgehalt',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const MacroLevelSelector(
                        macroLevel: MacroLevel.low,
                        macroType: MacroType.fat,
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 10),
                      const MacroLevelSelector(
                        macroLevel: MacroLevel.medium,
                        macroType: MacroType.fat,
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 10),
                      const MacroLevelSelector(
                        macroLevel: MacroLevel.high,
                        macroType: MacroType.fat,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Zuckergehalt',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const MacroLevelSelector(
                        macroLevel: MacroLevel.low,
                        macroType: MacroType.sugar,
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 10),
                      const MacroLevelSelector(
                        macroLevel: MacroLevel.medium,
                        macroType: MacroType.sugar,
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 10),
                      const MacroLevelSelector(
                        macroLevel: MacroLevel.high,
                        macroType: MacroType.sugar,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 2),
              ButtonRow(mealType: mealType),
              SizedBox(height: SizeConfig.blockSizeVertical * 4),
            ],
          ),
        ),
      ),
    );
  }
}

class MacroLevelSelector extends StatelessWidget {
  final MacroLevel macroLevel;
  final MacroType macroType;

  const MacroLevelSelector({
    super.key,
    required this.macroLevel,
    required this.macroType,
  });

  @override
  Widget build(BuildContext context) {
    IngredientsTrackingController controller = Get.find();

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (macroType == MacroType.fat) {
            controller.currentlySelectedFatLevel.value = macroLevel;
          } else {
            controller.currentlySelectedSugarLevel.value = macroLevel;
          }
        },
        child: Obx(() {
          Color selectorColor = Colors.white;

          if (macroType == MacroType.fat &&
                  controller.currentlySelectedFatLevel.value == macroLevel ||
              macroType == MacroType.sugar &&
                  controller.currentlySelectedSugarLevel.value == macroLevel) {
            selectorColor = mainColor;
          }

          Color textColor = Colors.black;

          if (selectorColor == mainColor) {
            textColor = Colors.white;
          }

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: selectorColor,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: mainColor),
            ),
            child: Center(
              child: Text(
                Helpers.getMacroLevelString(macroLevel: macroLevel),
                style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class ButtonRow extends StatelessWidget {
  final MealType mealType;

  const ButtonRow({super.key, required this.mealType});

  @override
  Widget build(BuildContext context) {
    IngredientsTrackingController controller = Get.find();

    return Obx(() {
      bool isEnabled = false;

      if (controller.currentlySelectedSugarLevel.value != null &&
          controller.currentlySelectedFatLevel.value != null) {
        isEnabled = true;
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();

              controller.clearCurrentlySelected();
            },
            icon: const Icon(
              CupertinoIcons.clear_circled,
              color: mainColor,
              size: 26,
            ),
          ),
          IconButton(
            onPressed: isEnabled
                ? () {
                    // we use the update methode here, because the meals value would not be updated directly
                    // without setting the whole map again. This is necessary to update the UI
                    controller.meals.update((val) {
                      val ??= <MealType, List<MacroEntry>>{};

                      val[mealType] = [
                        MacroEntry(
                          macroType: MacroType.fat,
                          macroLevel:
                              controller.currentlySelectedFatLevel.value!,
                        ),
                        MacroEntry(
                          macroType: MacroType.sugar,
                          macroLevel:
                              controller.currentlySelectedSugarLevel.value!,
                        ),
                      ];
                    });

                    Navigator.of(context).pop();

                    controller.clearCurrentlySelected();
                  }
                : null,
            icon: Icon(
              CupertinoIcons.check_mark_circled_solid,
              color: isEnabled ? mainColor : Colors.grey,
              size: 26,
            ),
          ),
        ],
      );
    });
  }
}
