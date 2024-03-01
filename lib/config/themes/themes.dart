import 'package:flutter/material.dart';

class StoryTheme {
  ThemeData lightStoryTheme() {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }

  AppBarTheme appBarTheme() {
    return const AppBarTheme(
      color: Colors.white,
      elevation: 0,
      centerTitle: true,
    );
  }

  ThemeData darkStoryTheme() {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        color: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
