import 'package:flutter/material.dart';
import 'package:super_meal_v2/Screns/filter_screen.dart';
import 'package:super_meal_v2/Screns/meal_detail_screen.dart';
import 'package:super_meal_v2/widgets/meal_item.dart';

import '../models/meal.dart';

class MealsScreen extends StatelessWidget {
  final String? title;
  final List<Meal>meals;


  const MealsScreen({
    super.key,
    this.title,
    required this.meals,

  });
  void onMealSelected(BuildContext context,Meal meal){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=> MealDetailScreen(
        meal: meal,

      ))
    );
  }
  @override
  Widget build(BuildContext context) {


    Widget content= Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Uh oh ... nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Try selecting a different category!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ],
      )
    );



    //meals isn't empty
    if(meals.isNotEmpty){
      content= ListView.builder(
        itemCount: meals.length,
          itemBuilder: (context,index)=>MealItem(
              meal: meals[index],
            onSelectMeal: (meal){
                onMealSelected(context, meal);
            },
          ));
    }
    if(title==null){
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
        body: content);
  }
}
