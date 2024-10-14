import 'package:flutter/material.dart';
import 'package:super_meal_v2/data/dummy_data.dart';
import 'package:super_meal_v2/models/category.dart';
import 'package:super_meal_v2/widgets/category_grid_item.dart';

import '../models/meal.dart';
import 'meals_screen.dart';

class CatagoriesScreen extends StatelessWidget {
  final List<Meal> availableMeals;

  const CatagoriesScreen({
    super.key,

    required this.availableMeals,
  });

  void _onSelectCatagory(BuildContext context, Category category) {
    //filtering by category
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category
            .id)) //ekta ekta meal check korbe .selected meal er catagory meal e true nahoi false
        .toList();

    //Lifting the state up
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MealsScreen(
                  title: category.title,
                  meals: filteredMeals,

                ))
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: [
        // availableCategory.map((category)=>
        // CategoryGridItem(category: category)
        // ).toList()//eta use korle children er [] utay dite hobe
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _onSelectCatagory(context, category);
            },
          )
      ],
    );
  }
}
