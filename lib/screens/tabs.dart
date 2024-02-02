import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/providers/favorites_provider.dart';

// Initial filter settings - all set to false.
const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

// TabsScreen class, a stateful widget to handle navigation between categories and favorites.
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

// Private State class for TabsScreen.
class _TabsScreenState extends ConsumerState<TabsScreen> {
  // Index to keep track of the currently selected tab.
  int _selectedPageIndex = 0;

  // Function to handle page selection from the bottom navigation bar.
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  // Function to handle screen navigation from the drawer.
  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final activeFilters = ref.watch(filtersProvider);
    // Filtering meals based on selected filters.
    final availableMeals = meals.where((meal) {
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
      return true;
    }).toList();

    // Default page is CategoriesScreen.
    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    // Updating the active page and title based on the selected tab.
    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMelasProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Your Favorites';
    }

    // Building the main scaffold of the app.
    return Scaffold(
      appBar: AppBar(
        title: Text(
            activePageTitle), // Displaying the title of the current screen.
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen, // Drawer for navigation.
      ),
      body: activePage, // Current screen content.
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage, // Handling tab selection.
        currentIndex: _selectedPageIndex, // Current tab index.
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
