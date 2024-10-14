import 'package:engaige_assessment/constants/colors.dart';
import 'package:engaige_assessment/features/track_food_ingredients/presentation/ingredients_tracking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      IngredientsTrackingController controller = Get.find();

      return controller.allFilledOut.value
          ? ElevatedButton(
              onPressed: () {
                controller.storeData();

                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                visualDensity: const VisualDensity(vertical: -1),
                backgroundColor: mainColor,
                padding: const EdgeInsets.symmetric(horizontal: 50),
              ),
              child: const Text(
                'Speichern',
                style: TextStyle(color: Colors.white),
              ),
            )
          : const SizedBox();
    });
  }
}
