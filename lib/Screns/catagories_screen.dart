import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:super_meal_v2/data/dummy_data.dart';
import 'package:super_meal_v2/models/category.dart';
import 'package:super_meal_v2/widgets/category_grid_item.dart';

import '../models/meal.dart';
import 'meals_screen.dart';

class CatagoriesScreen extends StatefulWidget {
  final List<Meal> availableMeals;

  const CatagoriesScreen({
    super.key,

    required this.availableMeals,
  });

  @override
  State<CatagoriesScreen> createState() => _CatagoriesScreenState();
}

class _CatagoriesScreenState extends State<CatagoriesScreen> with SingleTickerProviderStateMixin{
  void _onSelectCatagory(BuildContext context, Category category) {
    //filtering by category
    final filteredMeals = widget.availableMeals
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
  late AnimationController _animationController ;
  @override
  void initState() {
    _animationController=AnimationController(
        vsync:this,
      duration: Duration(milliseconds: 300),
      lowerBound: 0,//animation suru hobe kotha theke
      upperBound: 1
    );
    _animationController.forward();
    super.initState();
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child:GridView(
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
      ),
      builder: (context,child) => SlideTransition(
        position: Tween(
          begin: Offset(0,0.3),
          end: Offset(0,0),
        ).animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOut)),
          child: child,
      ),

    );
  }
}
