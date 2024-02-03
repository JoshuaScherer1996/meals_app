import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

// Defines a StatefulWidget for displaying categories.
class CategoriesScreen extends StatefulWidget {
  // Constructor requiring a list of meals that are available.
  const CategoriesScreen({
    super.key,
    required this.availableMeals, // List of meals to display in categories.
  });

  // Declaration of a final List of Meal objects.
  final List<Meal> availableMeals;

  // Creates the mutable state for this widget.
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

// Private State class for CategoriesScreen, handling animations and UI logic.
class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  // Late initialization of an AnimationController.
  late AnimationController _animationController;

  // Initializes the state, setting up the animation controller.
  @override
  void initState() {
    super.initState();

    // Initializing the animation controller with a specified duration and bounds.
    _animationController = AnimationController(
      vsync: this, // Current class instance as the vsync provider.
      duration: const Duration(milliseconds: 300), // Animation duration.
      lowerBound: 0, // Starting point of the animation value.
      upperBound: 1, // Ending point of the animation value.
    );

    // Starts the animation towards the upper bound.
    _animationController.forward();
  }

  // Disposes the animation controller to free up resources when the widget is removed from the widget tree.
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Function to handle the selection of a category.
  void _selectCategory(BuildContext context, Category category) {
    // Filtering meals that belong to the selected category.
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    // Navigating to the MealsScreen with the selected category's meals.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  // Overriding the build method to define the UI of CategoriesScreen.
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController, // Links the builder to the controller.
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          // Creating a list of CategoryGridItem widgets for each available category.
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            ),
        ],
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3), // Starting offset for the animation.
          end: const Offset(0, 0), // Ending offset for the animation.
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut, // Animation curve.
          ),
        ),
        child: child, // The child widget to animate.
      ),
    );
  }
}
