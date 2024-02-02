import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:meals_app/providers/favorites_provider.dart';

// Constant map for initial dietary filters settings.
const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

// TabsScreen widget, a consumer stateful widget to leverage Riverpod for state management.
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  // Index to keep track of the currently selected page in the bottom navigation bar.
  int _selectedPageIndex = 0;

  // Method to update the selected page index and rebuild the widget with the new page.
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  // Method to navigate to the FiltersScreen based on drawer selection.
  void _setScreen(String identifier) async {
    Navigator.of(context).pop(); // Close the drawer before navigating.
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
    // Watching the filteredMealsProvider to get the list of available meals based on selected filters.
    final availableMeals = ref.watch(filteredMealsProvider);

    // Default active page is CategoriesScreen, showing available meals based on filters.
    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    // If the Favorites tab is selected, switch to the MealsScreen displaying favorite meals.
    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMelasProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Your Favorites';
    }

    // Main Scaffold with an AppBar, Drawer, and BottomNavigationBar for app navigation.
    return Scaffold(
      appBar: AppBar(
        title:
            Text(activePageTitle), // Title changes based on the selected tab.
      ),
      drawer: MainDrawer(
        onSelectScreen:
            _setScreen, // Passing method to handle screen selections from the drawer.
      ),
      body: activePage, // Displaying the active page based on the selected tab.
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage, // Handler for selecting tabs.
        currentIndex: _selectedPageIndex, // Current selected tab index.
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories', // Tab for meal categories.
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites', // Tab for favorite meals.
          ),
        ],
      ),
    );
  }
}
