import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const ROUTE_NAME = "/filters";
  final Function saveFilter;
  final Map<String,bool> currentFilters;

  FiltersScreen(this.currentFilters,this.saveFilter);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool glutenFree = false;
  bool vegetarian = false;
  bool vegan = false;
  bool lactoseFree = false;

  @override
  initState(){
    super.initState();

    glutenFree= widget.currentFilters['gluten'];
    lactoseFree= widget.currentFilters['lactose'];
    vegan=widget.currentFilters['vegan'];
    vegetarian=widget.currentFilters['vegetarian'];
  }

  Widget buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFilters={
                'gluten': glutenFree,
                'lactose': lactoseFree,
                'vegan': vegan,
                'vegetarian': vegetarian,
              };

              widget.saveFilter(context,selectedFilters);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Text(
            "Adjust your meal selection.",
            style: Theme.of(context).textTheme.title,
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              buildSwitchListTile(
                "Gluten-Free",
                "Only include gluten-free meals",
                glutenFree,
                (newValue) {
                  setState(() {
                    glutenFree = newValue;
                  });
                },
              ),
              buildSwitchListTile(
                "Lactose-Free",
                "Only include lactose-free meals",
                lactoseFree,
                (newValue) {
                  setState(() {
                    lactoseFree = newValue;
                  });
                },
              ),
              buildSwitchListTile(
                "Vegetarian",
                "Only include Vegetarian meals",
                vegetarian,
                (newValue) {
                  setState(() {
                    vegetarian = newValue;
                  });
                },
              ),
              buildSwitchListTile(
                "Vegan",
                "Only include vegan meals",
                vegan,
                (newValue) {
                  setState(() {
                    vegan = newValue;
                  });
                },
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
