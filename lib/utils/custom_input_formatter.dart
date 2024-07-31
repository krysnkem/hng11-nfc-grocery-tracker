import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Get the new input value
    String newText = newValue.text;

    // If the first character is a number, prevent input
    if (newText.isNotEmpty && isDigit(newText[0])) {
      return oldValue;
    }

    // If the first character is a space, prevent more spaces from being added
    final characters = newText.split('');
    if (characters.length >= 2) {
      if (characters[0] == ' ' && characters[1] == ' ') {
        return oldValue;
      }
    }

    // Allow the update
    return newValue;
  }

  bool isDigit(String character) {
    return character.contains(RegExp(r'[0-9]'));
  }
}
