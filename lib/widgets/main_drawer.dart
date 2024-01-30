import 'package:flutter/material.dart';

// MainDrawer class, a stateless widget for creating a drawer for navigation.
class MainDrawer extends StatelessWidget {
  // Constructor for MainDrawer.
  // It requires a callback function to handle screen selection.
  const MainDrawer({
    super.key,
    required this.onSelectScreen,
  });

  // Declaring the onSelectScreen callback.
  final void Function(String identifier) onSelectScreen;

  // Building the UI of the MainDrawer widget.
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Column widget to arrange items vertically inside the drawer.
      child: Column(
        children: [
          // Drawer header with a custom design.
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              // Gradient decoration for the header.
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            // Row to arrange header content horizontally.
            child: Row(
              children: [
                // Icon for the header.
                Icon(
                  Icons.fastfood,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 18),
                // Header title.
                Text(
                  'Cooking up!',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),
          // ListTile for navigation to the 'Meals' screen.
          ListTile(
            leading: Icon(
              Icons.restaurant,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Meals',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              onSelectScreen('meals'); // Executing the callback on tap.
            },
          ),
          // ListTile for navigation to the 'Filters' screen.
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Filters',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              onSelectScreen('filters'); // Executing the callback on tap.
            },
          )
        ],
      ),
    );
  }
}
