import 'package:engaige_assessment/constants/colors.dart';
import 'package:engaige_assessment/features/track_food_ingredients/presentation/cancel_button.dart';
import 'package:engaige_assessment/features/track_food_ingredients/presentation/ingredients_tracking_controller.dart';
import 'package:engaige_assessment/features/track_food_ingredients/presentation/progress_bar.dart';
import 'package:engaige_assessment/features/track_food_ingredients/presentation/save_button.dart';
import 'package:engaige_assessment/features/track_food_ingredients/presentation/tracking_tile.dart';
import 'package:engaige_assessment/utils/size_config.dart';
import 'package:flutter/material.dart';

class IngredientTrackingPage extends StatelessWidget {
  const IngredientTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        // half of the default value
        leadingWidth: 28,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            Text(
              'Ernährung',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 5),
            ProgressBar()
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: SizeConfig.blockSizeVertical * 2),
          const Divider(),
          SizedBox(height: SizeConfig.blockSizeVertical * 4),
          ListView.separated(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal * 5,
            ),
            itemCount: 4,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              MealType mealType = MealType.breakfast;

              if (index == 1) {
                mealType = MealType.lunch;
              } else if (index == 2) {
                mealType = MealType.dinner;
              } else if (index == 3) {
                mealType = MealType.snack;
              }

              return TrackingTile(mealType: mealType);
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: SizeConfig.blockSizeVertical * 2);
            },
          ),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SaveButton(),
                CancelButton(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
