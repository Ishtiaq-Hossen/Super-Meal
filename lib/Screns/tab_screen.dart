import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_meal_v2/Screns/catagories_screen.dart';
import 'package:super_meal_v2/Screns/filter_screen.dart';
import 'package:super_meal_v2/Screns/meals_screen.dart';
import 'package:super_meal_v2/providers/favourites_provider.dart';
import 'package:super_meal_v2/providers/meals_provider.dart';
import 'package:super_meal_v2/widgets/main_drawer.dart';
import '../models/meal.dart';
import '../providers/filter_provider.dart';

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







  void _setScreen(String identifier)async{
    Navigator.of(context).pop();
    if(identifier=='filters'){
      await Navigator.push<Map<Filter,bool>>(
          context,MaterialPageRoute(builder: (ctx)=>FilterScreen(

      )));

    }

  }


  @override
  Widget build(BuildContext context) {

    final availableMeals = ref.watch(filteredMealsProvider);
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
