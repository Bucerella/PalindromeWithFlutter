import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:palindrome_with_provider/palindrome.dart';

import 'constants.dart';


class PalindromeProvider with ChangeNotifier {
  List<Palindrome> _palindromes = [];
  bool _isLoading = true;

  List<Palindrome> get palindromes => _palindromes;
  bool get isLoading => _isLoading;

  Future<void> fetchData() async {
    try {
      String jsonString = await rootBundle.loadString("assets/data.json");
      List<String> testStrings = jsonDecode(jsonString).cast<String>();

      _palindromes = testStrings.map((text) {
        bool isPurePalindrome = _checkPurePalindrome(text);
        bool isPalindrome = _checkPalindrome(text);
        return Palindrome(
          text: text,
          isPurePalindrome: isPurePalindrome,
          isPalindrome: isPalindrome,
        );
      }).toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception('${Constants.str_failedPalindrome} $e');
    }
  }

  bool _checkPurePalindrome(String text) {
    String cleanedText = text.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
    String reversedText = cleanedText.split('').reversed.join();
    return text == reversedText;
  }

  bool _checkPalindrome(String text) {
    text = text.toLowerCase();
    text = text.replaceAll(RegExp(r"[^\w]"), "");
    int length = text.length;
    for (int i = 0; i < length / 2; i++) {
      if (text[i] != text[length - i - 1]) {
        return false;
      }
    }
    return true;
  }
}
