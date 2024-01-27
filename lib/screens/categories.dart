import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

// CategoriesScreen class that represents a screen displaying a grid of category items.
class CategoriesScreen extends StatelessWidget {
  // Constructor for CategoriesScreen.
  const CategoriesScreen({
    super.key,
    required this.onToggleFavortie,
    required this.availableMeals,
  });

  // Fields of CategoriesScreen.
  final void Function(Meal meal) onToggleFavortie;
  final List<Meal> availableMeals;

  // Function to handle the selection of a category.
  void _selectCategory(BuildContext context, Category category) {
    // Filtering meals that belong to the selected category.
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    // Navigating to the MealsScreen with the selected category's meals.
    // Alternative: Navigator.of(context).push(route)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          onToggleFavorite: onToggleFavortie,
        ),
      ),
    );
  }

  // Overriding the build method to define the UI of CategoriesScreen.
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      // Defining the layout structure of the grid.
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        // Creating a list of CategoryGridItem widgets for each available category.
        // Alternative: availableCategories.map((category) => CategoryGridItem(category: category)).toList();
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          ),
      ],
    );
  }
}
