import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/filters_screen.dart';
import 'package:flutter_complete_guide/screens/tabs_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Drawer(
      child: Column(
        children: [
          Container(
            height: mediaQuery.size.height * 0.2,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: FittedBox(
              child: Text(
                "Cooking Up....",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(TabsScreen.ROUTE_NAME);
            },
            leading: Icon(
              Icons.restaurant,
              size: 26,
            ),
            title: Text(
              "Meals",
              style: TextStyle(
                  fontFamily: "RobotoCondensed",
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(FiltersScreen.ROUTE_NAME);
            },
            leading: Icon(
              Icons.settings,
              size: 26,
            ),
            title: Text(
              "Filters",
              style: TextStyle(
                  fontFamily: "RobotoCondensed",
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
