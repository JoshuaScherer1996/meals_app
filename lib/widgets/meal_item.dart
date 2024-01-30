import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

// The MealItem widget, designed to represent a single meal in the UI.
class MealItem extends StatelessWidget {
  // Constructor for the MealItem widget.
  const MealItem({
    super.key,
    required this.meal, // The meal data to be displayed.
    required this.onSelectMeal, // Callback function when a meal is selected.
  });

  // Instance variable for meal data.
  final Meal meal;

  // Getter to format the complexity text.
  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1); // Capitalizing the first letter.
  }

  // Getter to format the affordability text.
  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1); // Capitalizing the first letter.
  }

  // Callback function type for selecting a meal.
  final void Function(Meal meal) onSelectMeal;

  // Building the UI of the MealItem widget.
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior:
          Clip.hardEdge, // Ensuring content doesn't overflow the card.
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectMeal(meal); // Triggering the provided callback on tap.
        },
        // Stacking widgets for layout.
        child: Stack(
          children: [
            // Fade in image for the meal.
            FadeInImage(
              placeholder: MemoryImage(
                  kTransparentImage), // Transparent image as a placeholder.
              image: NetworkImage(meal.imageUrl), // Image of the meal.
              fit: BoxFit.cover, // Covering the area without stretching.
              height: 200,
              width: double.infinity,
            ),
            // Positioned widget to align the text container at the bottom.
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              // Container for text details with a semi-transparent background.
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 44,
                ),
                // Column for title and meal traits.
                child: Column(
                  children: [
                    // Meal title.
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      // Long text gets cut off with dots...
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Row for displaying meal traits (duration, complexity, and affordability).
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
