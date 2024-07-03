import 'package:flutter/material.dart';
import 'package:palindrome_with_provider/view/palindrome_list_page.dart';
import 'package:palindrome_with_provider/view_model/palindrome_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PalindromeProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PalindromeListPage(),
      ),
    ),
  );
}
