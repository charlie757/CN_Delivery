import 'package:flutter/services.dart';

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove any non-numeric characters (allow only digits)
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Limit to 16 digits (typical card number length)
    if (newText.length > 16) {
      newText = newText.substring(0, 16);
    }

    // Format the text with spaces every 4 digits
    String formattedText = '';
    for (int i = 0; i < newText.length; i++) {
      formattedText += newText[i];
      if ((i + 1) % 4 == 0 && i + 1 != newText.length) {
        formattedText += ' ';  // Add space after every 4 digits
      }
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
