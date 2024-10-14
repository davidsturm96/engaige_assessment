import 'package:engaige_assessment/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'features/track_food_ingredients/presentation/ingredient_tracking_page.dart';
import 'features/track_food_ingredients/presentation/ingredients_tracking_controller.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            Get.put(IngredientsTrackingController());

            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const IngredientTrackingPage(),
              ),
            ).then((_) {
              Get.delete<IngredientsTrackingController>();
            });
          },
          style: ElevatedButton.styleFrom(backgroundColor: mainColor),
          child: const Text(
            'Essen tracken',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
