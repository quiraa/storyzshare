import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StoryTheme {
  ThemeData storyTheme() {
    return ThemeData(
      textTheme: GoogleFonts.poppinsTextTheme(),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: appBarTheme(),
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
    );
  }

  AppBarTheme appBarTheme() {
    return const AppBarTheme(
      color: Colors.white,
      elevation: 0,
      centerTitle: true,
    );
  }
}
