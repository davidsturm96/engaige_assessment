import 'package:engaige_assessment/constants/colors.dart';
import 'package:engaige_assessment/features/track_food_ingredients/presentation/ingredients_tracking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    IngredientsTrackingController controller = Get.find();

    return Obx(() {
      return controller.somethingHasChanged.value
          ? ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                side: const BorderSide(color: mainColor),
                visualDensity: const VisualDensity(vertical: -1),
                padding: const EdgeInsets.symmetric(horizontal: 50),
              ),
              child: const Text(
                'Abbrechen',
                style: TextStyle(color: Colors.black),
              ),
            )
          : const SizedBox();
    });
  }
}
