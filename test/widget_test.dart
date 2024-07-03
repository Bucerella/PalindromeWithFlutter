// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:palindrome_with_provider/utilities/constants.dart';
import 'package:palindrome_with_provider/view/palindrome_list_page.dart';


void main() {
  testWidgets('Check texts and key', (WidgetTester tester) async {
    await tester.pumpWidget(PalindromeListPage());
    expect(find.byKey(const Key(Constants.str_mainContainerKey)), findsOneWidget);

    expect(find.text(Constants.str_palindromeAndPure), findsOneWidget);
    expect(find.text(Constants.str_purePalindrome), findsOneWidget);
    expect(find.text(Constants.str_palindrome), findsOneWidget);
  });
}