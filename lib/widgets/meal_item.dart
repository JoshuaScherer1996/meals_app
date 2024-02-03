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
        // Stack widget allows for overlaying of multiple widgets on top of each other.
        child: Stack(
          children: [
            // Hero widget creates a smooth animation between two screens for a shared element.
            // In this case, the shared element is the image of a meal.
            Hero(
              tag: meal
                  .id, // Unique tag to identify the Hero animation source and destination.
              // FadeInImage widget is used to smoothly display images as they load.
              // It shows a placeholder image until the target image is loaded.
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
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
