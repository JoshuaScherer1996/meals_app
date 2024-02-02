import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';

// Defines a provider named 'mealsProvider'.
// This provider is responsible for making the list of dummy meals available throughout the app.
// The Provider is a basic provider from Riverpod, which is used here to read and expose data.
final mealsProvider = Provider((ref) {
  // The provider returns the 'dummyMeals' data, which is expected to be a list of meal objects.
  // This data comes from 'dummy_data.dart', serving as a static or initial data source.
  // 'ref' is a reference to the provider itself, which could be used to read other providers if necessary.
  return dummyMeals;
});
