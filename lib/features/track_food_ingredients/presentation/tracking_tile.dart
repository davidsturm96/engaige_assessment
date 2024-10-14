import 'package:engaige_assessment/constants/colors.dart';
import 'package:engaige_assessment/features/track_food_ingredients/domain/MacroEntry.dart';
import 'package:engaige_assessment/features/track_food_ingredients/presentation/ingredients_tracking_controller.dart';
import 'package:engaige_assessment/features/track_food_ingredients/presentation/input_modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/helpers.dart';

class TrackingTile extends StatelessWidget {
  final MealType mealType;

  const TrackingTile({super.key, required this.mealType});

  @override
  Widget build(BuildContext context) {
    IngredientsTrackingController controller = Get.find();

    return Obx(() {
      bool isSubTitleEmpty = false;

      if (controller.meals.value?[mealType] == null) {
        isSubTitleEmpty = true;
      }

      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: Colors.white,
        ),
        child: ListTile(
          visualDensity: VisualDensity(vertical: isSubTitleEmpty ? 1 : 4),
          leading: const SizedBox(),
          minLeadingWidth: 0,
          tileColor: Colors.transparent,
          title: Text(
            Helpers.getMealTypeString(mealType: mealType),
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          subtitle: isSubTitleEmpty ? null : SubTitleRow(mealType: mealType),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              EditButton(mealType: mealType),
              const SizedBox(width: 8),
              AddButton(mealType: mealType),
            ],
          ),
        ),
      );
    });
  }
}

class SubTitleRow extends StatelessWidget {
  final MealType mealType;

  const SubTitleRow({super.key, required this.mealType});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MacroChip(mealType: mealType, macroType: MacroType.fat),
        const SizedBox(width: 10),
        MacroChip(mealType: mealType, macroType: MacroType.sugar),
      ],
    );
  }
}

class MacroChip extends StatelessWidget {
  final MealType mealType;
  final MacroType macroType;

  const MacroChip({super.key, required this.mealType, required this.macroType});

  @override
  Widget build(BuildContext context) {
    IngredientsTrackingController controller = Get.find();

    MacroLevel? fatLevel;
    MacroLevel? sugarLevel;

    List<MacroEntry>? macros = controller.meals.value?[mealType];

    if (macros != null) {
      for (var macro in macros) {
        if (macro.macroType == MacroType.fat && macroType == MacroType.fat) {
          fatLevel = macro.macroLevel;
        } else if (macro.macroType == MacroType.sugar &&
            macroType == MacroType.sugar) {
          sugarLevel = macro.macroLevel;
        }
      }
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: mainColor, width: 0.6),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5, top: 2, bottom: 2),
            child: Text(
              macroType == MacroType.fat ? 'Fett' : 'Zucker',
              style: const TextStyle(fontSize: 12, color: mainColor),
            ),
          ),
          const SizedBox(width: 3),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              Helpers.getMacroLevelString(macroLevel: fatLevel ?? sugarLevel!),
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  final MealType mealType;

  const AddButton({super.key, required this.mealType});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          builder: (context) {
            return InputModalBottomSheet(mealType: mealType);
          },
        );
      },
      style: IconButton.styleFrom(
        backgroundColor: mainColor,
        padding: EdgeInsets.zero,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      icon: const Icon(Icons.add, color: Colors.white, size: 18),
    );
  }
}

class EditButton extends StatelessWidget {
  final MealType mealType;

  const EditButton({super.key, required this.mealType});

  @override
  Widget build(BuildContext context) {
    IngredientsTrackingController controller = Get.find();

    bool isVisible = controller.meals.value?[mealType] != null;

    return isVisible
        ? IconButton(
            onPressed: () {
              late MacroLevel fatLevel;
              late MacroLevel sugarLevel;

              for (var macroEntry in controller.meals.value![mealType]!) {
                if (macroEntry.macroType == MacroType.fat) {
                  fatLevel = macroEntry.macroLevel;
                } else {
                  sugarLevel = macroEntry.macroLevel;
                }
              }

              controller.currentlySelectedFatLevel.value = fatLevel;
              controller.currentlySelectedSugarLevel.value = sugarLevel;

              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                builder: (context) {
                  return InputModalBottomSheet(mealType: mealType);
                },
              );
            },
            style: IconButton.styleFrom(
              backgroundColor: mainColor,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            ),
            icon: const Icon(Icons.edit, color: Colors.white, size: 16),
          )
        : const SizedBox();
  }
}
