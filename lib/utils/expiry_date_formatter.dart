import 'package:flutter/services.dart';

class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), ''); // Remove non-numeric characters

    if (newText.length > 4) {
      newText = newText.substring(0, 4); // Limit to 4 digits
    }

    String formattedText = '';
    if (newText.length >= 3) {
      // Add separator only if there are at least 2 digits for the month
      // and 2 digits for the year
      formattedText = '${newText.substring(0, 2)}';
      if (newText.length > 2) {
        formattedText += '/${newText.substring(2, newText.length)}'; // Dynamically add '/' and year
      }
    } else {
      formattedText = newText; // If less than 3 digits, just show the entered digits
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
