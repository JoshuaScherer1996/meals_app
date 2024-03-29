import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals_app/screens/tabs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Defining a global theme for the application using ThemeData.
final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

// Main entry point of the Flutter application.
void main() {
  runApp(
    // Wrapping the root App widget with ProviderScope for Riverpod state management.
    const ProviderScope(
      child: App(),
    ),
  );
}

// Defines the root widget of the application and initial setup.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home:
          const TabsScreen(), // Setting the home screen to TabsScreen, which controls the main navigation.
      debugShowCheckedModeBanner: false,
    );
  }
}
