import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';

// CategoryGridItem class, a stateless widget for representing a category in a grid layout.
class CategoryGridItem extends StatelessWidget {
  // Constructor for CategoryGridItem.
  // It requires a Category object and a callback function for when the category is selected.
  const CategoryGridItem({
    super.key,
    required this.category,
    required this.onSelectCategory,
  });

  // Declaring the category data and onSelectCategory callback.
  final Category category;
  final void Function() onSelectCategory;

  // Building the UI of the CategoryGridItem widget.
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectCategory, // Executing the provided callback on tap.
      splashColor: Theme.of(context)
          .primaryColor, // Splash color when the item is tapped.
      borderRadius:
          BorderRadius.circular(16), // Rounded corners for the tap effect.
      // Container to style the visual appearance of the category item.
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          // Linear gradient background for visual appeal.
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        // Text widget to display the category title.
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
