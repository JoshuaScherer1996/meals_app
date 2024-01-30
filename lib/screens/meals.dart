import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:meals_app/widgets/meal_item.dart';

// MealsScreen class, a stateless widget for displaying a list of meals.
class MealsScreen extends StatelessWidget {
  // Constructor for MealsScreen.
  // It requires a list of Meal objects and a callback function for toggling the favorite status.
  const MealsScreen(
      {super.key,
      this.title,
      required this.meals,
      required this.onToggleFavorite});

  // Declaring the title, list of meals, and the onToggleFavorite callback.
  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorite;

  // Function to navigate to the MealDetailsScreen with a selected meal.
  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  // Building the UI of the MealsScreen widget.
  @override
  Widget build(BuildContext context) {
    // Using a ListView.builder for efficiently displaying a list of meals.
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) => MealItem(
        meal: meals[index],
        onSelectMeal: (meal) {
          _selectMeal(
              context, meal); // Navigating to details on meal selection.
        },
      ),
    );

    // Showing a message when no meals are available.
    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Nothing here!',
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
        ),
      );
    }

    // Returning only the content if there is no title.
    if (title == null) {
      return content;
    }

    // Wrapping the content in a Scaffold with an AppBar if there is a title.
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content, // The main content (list of meals or message).
    );
  }
}
