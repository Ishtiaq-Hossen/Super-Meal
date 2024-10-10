import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/meal.dart';

class MealsScreen extends StatelessWidget {
  final String title;
  final List<Meal>meals;


  const MealsScreen({
    super.key,
    required this.title,
    required this.meals
  });

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
      content= Container(

        padding: EdgeInsets.all(16),

        child: ListView.builder(
          itemCount: meals.length,
            itemBuilder: (context,index)=>Column(

              children: [
                InkWell(
                  onTap: (){

                  },
                  child: Text(

                    meals[index].title,
                    style: TextStyle(height: 2, fontSize: 15,fontWeight: FontWeight.bold,),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20), // Image border
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(150), // Image radius
                    child: Image.network(meals[index].imageUrl, fit: BoxFit.cover),
                  ),
                )
              ]
            )),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
        body: content);
  }
}
