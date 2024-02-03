import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorites_provider.dart';

// MealDetailsScreen is a ConsumerWidget that uses Riverpod for state management.
// It displays detailed information about a meal and allows users to mark a meal as a favorite.
class MealDetailsScreen extends ConsumerWidget {
  // Constructor requires a Meal object to display details for.
  const MealDetailsScreen({
    super.key,
    required this.meal, // Meal object containing details to be displayed.
  });

  // Final property to hold the Meal object passed to the widget.
  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watching the favoriteMealsProvider to get the current list of favorite meals.
    final favoriteMeals = ref.watch(favoriteMelasProvider);

    // Checking if the current meal is in the list of favorite meals.
    final isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title), // Displaying the meal's title on the AppBar.
        actions: [
          // IconButton to toggle the favorite status of the meal.
          IconButton(
            onPressed: () {
              // Calling toggleMealFavoriteStatus on favoriteMealsProvider to update the meal's favorite status.
              final wasAdded = ref
                  .read(favoriteMelasProvider.notifier)
                  .toggleMealFavoriteStatus(meal);
              // Clearing any existing snack bars to prevent stacking.
              ScaffoldMessenger.of(context).clearSnackBars();
              // Displaying a SnackBar to inform the user of the updated favorite status.
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      wasAdded ? 'Meal added as favorite.' : 'Meal removed.'),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: animation,
                  child: child,
                );
              },
              child: Icon(isFavorite ? Icons.star : Icons.star_border),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        // Using SingleChildScrollView to prevent overflow and allow for scrolling.
        child: Column(
          children: [
            Image.network(
              meal.imageUrl, // Displaying the meal's image.
              height: 300,
              width: double.infinity,
              fit: BoxFit
                  .cover, // Ensuring the image covers the allotted space while maintaining aspect ratio.
            ),
            const SizedBox(height: 14),
            // Section title for ingredients.
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 14),
            // Listing all ingredients of the meal.
            for (final ingredient in meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            const SizedBox(height: 24),
            // Section title for cooking steps.
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 14),
            // Displaying each cooking step with padding for readability.
            for (final step in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
            const SizedBox(height: 16) // Additional spacing at the end.
          ],
        ),
      ),
    );
  }
}
