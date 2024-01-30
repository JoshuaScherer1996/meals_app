import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

// Initial filter settings - all set to false.
const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

// TabsScreen class, a stateful widget to handle navigation between categories and favorites.
class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

// Private State class for TabsScreen.
class _TabsScreenState extends State<TabsScreen> {
  // Index to keep track of the currently selected tab.
  int _selectedPageIndex = 0;
  // List to keep track of favorite meals.
  final List<Meal> _favoriteMeals = [];
  // Map to keep track of selected filters.
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  // Function to show a snack bar message.
  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // Function to toggle the favorite status of a meal.
  void _toggleMealFavoritesStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage('Meal is no longer a favorite.');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessage('Meal is now a favorite!');
      });
    }
  }

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
    // Filtering meals based on selected filters.
    final availableMeals = .where((meal) {
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
      onToggleFavortie: _toggleMealFavoritesStatus,
    );
    var activePageTitle = 'Categories';

    // Updating the active page and title based on the selected tab.
    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoritesStatus,
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
