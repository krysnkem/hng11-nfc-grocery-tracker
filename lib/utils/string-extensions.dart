import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();
const ext = 0;
String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));


extension StringCasingExtension on String {
  String? camelCase() => toBeginningOfSentenceCase(this);

  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');

  String? trimToken() => contains(":") ? split(":")[1].trim() : this;

  String? trimSpaces() => replaceAll(" ", "");
}

extension NumExtensions on int {
  num addPercentage(num v) => this + ((v / 100) * this);

  num getPercentage(num v) => ((v / 100) * this);
}

class NumericTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Use a regular expression to remove non-numeric characters
    final filteredValue = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    return TextEditingValue(
      text: filteredValue,
      selection: TextSelection.collapsed(offset: filteredValue.length),
    );
  }
}
