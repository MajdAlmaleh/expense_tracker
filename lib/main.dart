import 'package:flutter/material.dart';
import 'widgets/expenses.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  var kcolorTheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 147, 210, 233),
  );

  var kcolorDarkTheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 4, 39, 52),
  );

  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: kcolorDarkTheme,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kcolorDarkTheme.primaryContainer,
            ),
          )),
      theme: ThemeData().copyWith(
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kcolorTheme.inversePrimary,
          foregroundColor: kcolorTheme.onBackground,
        ),
        useMaterial3: true,
        colorScheme: kcolorTheme,
        cardTheme: const CardTheme().copyWith(
          margin: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kcolorTheme.primaryContainer,
          ),
        ),
      ),
      home: const Expenses(),
    ),
  );
}
