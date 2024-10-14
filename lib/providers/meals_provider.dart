import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_meal_v2/data/dummy_data.dart';

final mealsProvider =Provider((ref) {
  return dummyMeals;
});