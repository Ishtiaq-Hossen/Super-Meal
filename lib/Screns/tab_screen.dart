import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_meal_v2/Screns/catagories_screen.dart';
import 'package:super_meal_v2/Screns/filter_screen.dart';
import 'package:super_meal_v2/Screns/meals_screen.dart';
import 'package:super_meal_v2/providers/favourites_provider.dart';
import 'package:super_meal_v2/providers/meals_provider.dart';
import 'package:super_meal_v2/widgets/main_drawer.dart';
import '../models/meal.dart';
const KInitialFilter= {
  Filter.glutenFree:false,
  Filter.lactoseFree:false,
  Filter.vegan:false,
  Filter.vegetarian:false,

};
class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int _selectedPageIndex = 0;

  void _changeScreen(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }


  Map<Filter,bool>_selectedFilters=KInitialFilter;




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
    final meals= ref.read(mealsProvider);
    final availableMeals = meals.where((meal) {
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

      availableMeals: availableMeals,
    );
    var activeTitle = 'Categories';
    final _favouriteMeals = ref.watch(favouriteMealsProvider);
    if (_selectedPageIndex == 1) {
      activeScreen = MealsScreen(
        meals: _favouriteMeals,

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
