import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

// Define an enumeration 'Filter' with four types of dietary restrictions.
enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

// Declare 'FiltersNotifier' class that extends 'StateNotifier' with a state of type Map<Filter, bool>.
// This class manages the state of dietary filters.
class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  // Initialize the state with all filters set to false indicating that no dietary filters are applied initially.
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false
        });

  // Method to update the state with a new set of chosen filters.
  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  // Method to update the state for a single filter.
  // This allows toggling a specific filter on or off.
  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

// Provider 'filtersProvider' is defined to manage the filters state.
// It creates an instance of 'FiltersNotifier', which holds the state of dietary filters.
final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);

// Provider 'filteredMealsProvider' is defined to filter meals based on active dietary filters.
// It watches 'mealsProvider' for the list of meals and 'filtersProvider' for the active filters.
final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);

  // Filter the list of meals based on the active dietary filters.
  return meals.where((meal) {
    // Apply each filter by checking if the filter is active and if the meal complies with the dietary restriction.
    // Returns false to exclude the meal if it does not comply with an active filter.
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true; // Include the meal if it passes all active filters.
  }).toList(); // Convert the filtered iterable back into a list.
});
