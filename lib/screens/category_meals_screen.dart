import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/meal.dart';

import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const ROUTE_NAME = '/categories';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);


  @override
  Widget build(BuildContext context) {
    final routeArguments =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryId = routeArguments['id'];
    final categoryTitle = routeArguments['title'];

    final categoryMeals = availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (_, index) {
          return MealItem(
              id: categoryMeals[index].id,
              title: categoryMeals[index].title,
              imageUrl: categoryMeals[index].imageUrl,
              duration: categoryMeals[index].duration,
              complexity: categoryMeals[index].complexity,
              affordability: categoryMeals[index].affordability);
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
