import 'package:engaige_assessment/constants/colors.dart';
import 'package:engaige_assessment/features/track_food_ingredients/presentation/ingredients_tracking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    IngredientsTrackingController controller = Get.find();

    return SizedBox(
      height: 7,
      child: Obx(() {
        return Row(
          children: controller.allFilledOut.value
              ? const [ProgressBarPart(onlyBorder: false)]
              : const [
                  ProgressBarPart(onlyBorder: false),
                  SizedBox(width: 10),
                  ProgressBarPart(onlyBorder: true),
                ],
        );
      }),
    );
  }
}

class ProgressBarPart extends StatelessWidget {
  final bool onlyBorder;

  const ProgressBarPart({super.key, required this.onlyBorder});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: onlyBorder ? null : mainColor,
          borderRadius: BorderRadius.circular(5),
          border: onlyBorder ? Border.all(color: mainColor) : null,
        ),
      ),
    );
  }
}
