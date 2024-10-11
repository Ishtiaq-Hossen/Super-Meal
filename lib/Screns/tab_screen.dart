
import 'package:flutter/material.dart';
import 'package:super_meal_v2/Screns/catagories_screen.dart';
import 'package:super_meal_v2/Screns/meals_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedPageIndex =0;
  void _changeScreen(int index){
    setState(() {
      _selectedPageIndex =index;
    });
  }
  @override
  Widget build(BuildContext context) {
    Widget activeScreen= CatagoriesScreen();
    var activeTitle='Categories';
    if(_selectedPageIndex==1){
      activeScreen= MealsScreen(title: 'Fav', meals: []);
      activeTitle= "Your Favourites";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activeTitle),
      ),
      body:activeScreen,
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index){
            _changeScreen(index);
          },
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.set_meal),label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.star),label: 'Favourites')
          ]
      ),
    );
  }
}
