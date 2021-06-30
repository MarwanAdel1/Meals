import 'package:flutter/material.dart';

import 'package:flutter_complete_guide/models/meal.dart';
import 'package:flutter_complete_guide/screens/filters_screen.dart';
import 'package:flutter_complete_guide/screens/meal_details_screen.dart';
import 'package:flutter_complete_guide/screens/tabs_screen.dart';

import 'data/dummy_data.dart';
import 'screens/category_meals_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals=[];

  void setFilters(BuildContext context, Map<String, bool> filtersData) {
    setState(() {
      filters = filtersData;

      availableMeals = DUMMY_MEALS.where((meal) {
        if (filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          content: Text("Saved"),
        ))
        .closed
        .then((_) {
      Navigator.of(context).pushReplacementNamed(TabsScreen.ROUTE_NAME);
    });
  }

  void toggleFavorites(String mealId){
    final existingIndex = favoriteMeals.indexWhere((meal) => meal.id==mealId);
    setState(() {
      if(existingIndex >=0){
        favoriteMeals.removeAt(existingIndex);
      }else{
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id==mealId ));
      }
    });
  }

  bool isFavorite(String mealId){
    return favoriteMeals.any((meal) => meal.id==mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              title: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ))),
      initialRoute: TabsScreen.ROUTE_NAME,
      routes: {
        FiltersScreen.ROUTE_NAME: (ctx) => FiltersScreen(filters, setFilters),
        TabsScreen.ROUTE_NAME: (ctx) => TabsScreen(favoriteMeals),
        CategoryMealsScreen.ROUTE_NAME: (ctx) => CategoryMealsScreen(availableMeals),
        MealDetailsScreen.ROUTE_NAME: (ctx) => MealDetailsScreen(toggleFavorites,isFavorite),
      },
    );
  }
}
