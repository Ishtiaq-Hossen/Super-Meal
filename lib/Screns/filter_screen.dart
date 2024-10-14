import 'package:flutter/material.dart';
enum Filter{
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan
}
class FilterScreen extends StatefulWidget {
  final Map<Filter,bool>currentFilters;
  const FilterScreen({
    super.key,
    required this.currentFilters
  });

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _glutenFreeFilterSet= false;
  var _lactoseFreeFilterSet =false;
  var _vegetarianFilterSet=false;
  var _veganFilterSet=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _glutenFreeFilterSet= widget.currentFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet=widget.currentFilters[Filter.lactoseFree]!;
    _veganFilterSet=widget.currentFilters[Filter.vegan]!;
    _vegetarianFilterSet= widget.currentFilters[Filter.vegetarian]!;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
      ),
      body: WillPopScope(
        onWillPop: () async{
          //we will set data when clearing navigation starts
          Navigator.of(context).pop(
            {
              Filter.glutenFree: _glutenFreeFilterSet,
              Filter.lactoseFree: _lactoseFreeFilterSet,
              Filter.vegan: _veganFilterSet,
              Filter.vegetarian: _vegetarianFilterSet

            }
          );
          return false;
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _glutenFreeFilterSet,
              onChanged: (newValue) {
                setState(() {
                  _glutenFreeFilterSet=newValue;
                });
              },
              title: Text('Gluten-Free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        
              ),
                subtitle: Text(
                    'Only include gluten-free meals',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                    )
                ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 30,right: 22),
            ),
            SwitchListTile(
              value: _lactoseFreeFilterSet,
              onChanged: (newValue) {
                setState(() {
                  _lactoseFreeFilterSet=newValue;
                });
              },
              title: Text('Lactose-Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),

              ),
              subtitle: Text(
                  'Only include lactose-free meals',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  )
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 30,right: 22),
            ),
            SwitchListTile(
              value: _veganFilterSet,
              onChanged: (newValue) {
                setState(() {
                  _veganFilterSet=newValue;
                });
              },
              title: Text('Vegan-Food',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),

              ),
              subtitle: Text(
                  'Only include vegan meals',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  )
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 30,right: 22),
            ),
            SwitchListTile(
              value: _vegetarianFilterSet,
              onChanged: (newValue) {
                setState(() {
                  _vegetarianFilterSet=newValue;
                });
              },
              title: Text('Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),

              ),
              subtitle: Text(
                  'Only include vegetarian meals',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  )
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 30,right: 22),
            )
          ],
        ),
      ),
    );
  }
}
