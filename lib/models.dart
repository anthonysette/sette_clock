import 'package:flutter/material.dart';

class StringColor {
  StringColor({this.color});

  // All Colors for users
  final Map<String, Color> allColors = {
    'blue': Color(0xFF7DB1f4), // blue
    'purple': Color(0xFFD77DF4), // purple
    'pink': Color(0xFFF47DDD), // pink
    'red': Color(0xFFF47D88), // red
    'orange': Color(0xFFF49D7D), // orange
    'yellow': Color(0xFFF4DE7D), // yellow
    'green': Color(0xFF7DF484), // green
    'sky blue': Color(0xFF7DF4F1), // sky blue
  };

  final String color;

  // Get Color by name (String)
  Color getColor() {
    return allColors[this.color];
  }
}
