import 'package:flutter/material.dart';

// Defines a 'Category'.
class Category {
  // Constructor for creating a new Category instance.
  // It requires 'id' and 'title', and optionally takes a 'color' which defaults to orange.
  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange,
  });

  // Declaration of instance variables for the Category class.
  final String id;
  final String title;
  final Color color;
}
