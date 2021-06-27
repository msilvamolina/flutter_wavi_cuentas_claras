import 'package:flutter/material.dart';

class Themes {
  final ThemeData theme = ThemeData();

  final lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.purple,
    colorScheme:
        ThemeData.light().colorScheme.copyWith(secondary: Colors.orange),
    cardColor: Colors.white,
    scaffoldBackgroundColor: Colors.grey[200],
    shadowColor: Colors.grey[400],
    unselectedWidgetColor: Colors.purple.shade800,
    toggleableActiveColor: Colors.purple.shade800,
  );
  final darkTheme = ThemeData.dark().copyWith(
    cardColor: Colors.black,
    colorScheme:
        ThemeData.dark().colorScheme.copyWith(secondary: Colors.amber[300]),
    unselectedWidgetColor: Colors.orange.shade800,
    toggleableActiveColor: Colors.orange.shade800,
  );
}
