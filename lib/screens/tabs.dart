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
  // Map to keep track of selected filters.
  Map<Filter, bool> _selectedFilters = kInitialFilters;

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
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            currentFilters: _selectedFilters,
          ),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Allows us to reexecute the build method whenever the mealsProvider changes.
    // Also returns our data which is how we get our meals here.
    final meals = ref.watch(mealsProvider);
    // Filtering meals based on selected filters.
    final availableMeals = meals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
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
