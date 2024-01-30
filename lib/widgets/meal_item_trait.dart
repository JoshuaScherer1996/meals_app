import 'package:flutter/material.dart';

// MealItemTrait: A reusable stateless widget to display an icon and a label.
class MealItemTrait extends StatelessWidget {
  // Constructor for MealItemTrait.
  // It requires two parameters: 'icon' for the IconData and 'label' for the text to be displayed.
  const MealItemTrait({
    super.key,
    required this.icon,
    required this.label,
  });

  // Declaring the icon data to be used in the widget.
  final IconData icon;
  // Declaring the label text to be displayed next to the icon.
  final String label;

  // Building the UI of the MealItemTrait widget.
  @override
  Widget build(BuildContext context) {
    // Using a Row to arrange the icon and text label horizontally.
    return Row(
      children: [
        // Displaying the icon.
        Icon(
          icon,
          size: 17,
          color: Colors.white,
        ),
        const SizedBox(
          width: 6,
        ),
        // Displaying the label text.
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
