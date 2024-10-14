import 'package:flutter/material.dart';
import 'package:super_meal_v2/Screns/catagories_screen.dart';
import 'package:super_meal_v2/Screns/filter_screen.dart';
import 'package:super_meal_v2/Screns/meals_screen.dart';
import 'package:super_meal_v2/widgets/main_drawer.dart';

import '../data/dummy_data.dart';
import '../models/meal.dart';
const KInitialFilter= {
  Filter.glutenFree:false,
  Filter.lactoseFree:false,
  Filter.vegan:false,
  Filter.vegetarian:false,

};
class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedPageIndex = 0;

  void _changeScreen(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  final List<Meal> _favouriteMeals = [];
  Map<Filter,bool>_selectedFilters=KInitialFilter;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _toggleMealFavouriteStatus(Meal meal) {
    final isExisting = _favouriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favouriteMeals.remove(meal);
      });

      _showInfoMessage('Meal is no longe a favourite.');
    } else {
      setState(() {
        _favouriteMeals.add(meal);
      });
      _showInfoMessage('Meal is saved as favourite.');
    }
  }
  void _setScreen(String identifier)async{
    Navigator.of(context).pop();
    if(identifier=='filters'){
      final result= await Navigator.push<Map<Filter,bool>>(
          context,MaterialPageRoute(builder: (ctx)=>FilterScreen(
        currentFilters: _selectedFilters,
      )));
      setState(() {
        _selectedFilters=result ?? KInitialFilter;
      });
    }

  }


  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if(_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree){
        return false;
      }
      if(_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree){
        return false;
      }
      if(_selectedFilters[Filter.vegan]! && !meal.isVegan){
        return false;
      }
      if(_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian){
        return false;
      }
      return true;
    }).toList();

    Widget activeScreen = CatagoriesScreen(
      onToggleFavourite: _toggleMealFavouriteStatus,
      availableMeals: availableMeals,
    );
    var activeTitle = 'Categories';
    if (_selectedPageIndex == 1) {
      activeScreen = MealsScreen(
        meals: _favouriteMeals,
        onToggleFavourite: (meal) {
          _toggleMealFavouriteStatus(meal);
        },
      );
      activeTitle = "Your Favourites";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activeTitle),
      ),
      body: activeScreen,
      drawer: MainDrawer(
        onSelecScreen: (identifier){
          _setScreen(identifier);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            _changeScreen(index);
          },
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favourites')
          ]),
    );
  }
}
