import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

// Defines FavoriteMealsNotifier class that extends StateNotifier with a state of List<Meal>.
// This class is responsible for managing the state of favorite meals.
class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  // Constructor initializes the state with an empty list of meals.
  FavoriteMealsNotifier() : super([]);

  // Method to toggle the favorite status of a given meal.
  // Returns true if the meal is now a favorite, or false if it has been removed from favorites.
  bool toggleMealFavoriteStatus(Meal meal) {
    // Check if the meal is already marked as favorite.
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      // If the meal is a favorite, remove it from the state and return false.
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      // If the meal is not a favorite, add it to the state and return true.
      state = [...state, meal];
      return true;
    }
  }
}

// Defines a provider for managing favorite meals.
// This provider is used to create and interact with the FavoriteMealsNotifier.
final favoriteMelasProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  // Returns an instance of FavoriteMealsNotifier.
  return FavoriteMealsNotifier();
});
