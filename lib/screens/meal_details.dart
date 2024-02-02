import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorites_provider.dart';

// MealDetailsScreen class, a stateless widget for displaying meal details.
class MealDetailsScreen extends ConsumerWidget {
  // Constructor for MealDetailsScreen.
  // It requires a Meal object and a callback function for toggling favorite status.
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  // Declaring the meal and onToggleFavorite callback.
  final Meal meal;

  // Building the UI of the MealDetailsScreen widget.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMelasProvider);

    final isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title), // Displaying the meal's title in the AppBar.
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteMelasProvider.notifier)
                  .toggleMealFavoriteStatus(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      wasAdded ? 'Meal added as favorite.' : 'Meal removed.'),
                ),
              );
            },
            icon: Icon(isFavorite
                ? Icons.star
                : Icons.star_border), // Star icon for the favorite button.
          )
        ],
      ),
      // Using SingleChildScrollView to allow the body to be scrollable.
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Displaying the meal's image.
            Image.network(
              meal.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit
                  .cover, // Covering the width of the screen while maintaining aspect ratio.
            ),
            const SizedBox(height: 14),
            // Title for the ingredients section.
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 14),
            // Displaying each ingredient of the meal.
            for (final ingredient in meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            const SizedBox(height: 24),
            // Title for the steps section.
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 14),
            // Displaying each step in the meal's preparation process.
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
            const SizedBox(height: 16)
          ],
        ),
      ),
    );
  }
}
