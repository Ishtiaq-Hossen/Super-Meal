import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_meal_v2/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';
import '../models/meal.dart';


class MealItem extends StatelessWidget {
  final Meal meal;
  final Function(Meal meal) onSelectMeal;

  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal
  });
  String get affordabilityTest{
    return meal.affordability.name[0].toUpperCase()+meal.affordability.name.substring(1);
  }
  String get complexityTest{
    return meal.complexity.name[0].toUpperCase()+meal.complexity.name.substring(1);
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
      ),
      child: InkWell(
        onTap: (){
          onSelectMeal(meal);
        },
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
        
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 45,
                vertical: 8
                ),
                color: Colors.black54,
                child: Column(
                  children:[
                    Text(
                    meal.title,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                    Row(

                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                            MealItemTrait(
                              icon: Icons.schedule,
                              label: '${meal.duration} mins',
                            ),
                            const SizedBox(width: 8),
                            MealItemTrait(
                              icon: Icons.work,
                              label: complexityTest,
                            ),
                            const SizedBox(width: 8),
                            MealItemTrait(
                              icon: Icons.attach_money,
                              label: affordabilityTest,
                            )

                      ],
                    )
        
        
                  ]
                )
              ),
            )
        
          ],
        ),
      ),
    );
  }
}
