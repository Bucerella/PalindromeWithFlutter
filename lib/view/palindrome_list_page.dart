import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palindrome_with_provider/utilities/constants.dart';
import 'package:palindrome_with_provider/model/palindrome.dart';
import 'package:palindrome_with_provider/view_model/palindrome_provider.dart';
import 'package:provider/provider.dart';

class PalindromeListPage extends StatefulWidget {
  const PalindromeListPage({super.key});

  @override
  State<PalindromeListPage> createState() => _PalindromeListPageState();
}

class _PalindromeListPageState extends State<PalindromeListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Constants.str_palindromeAndPure,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrange.withOpacity(0.8),
        elevation: 4,
      ),
      body: Consumer<PalindromeProvider>(
        builder: (context, provider, _) {
          return provider.isLoading // Check if provider is loading (null-safe)
              ? const Center(child: CircularProgressIndicator())
              : _buildPalindromeList(provider.palindromes); // Access palindromes (null-safe)
        },
      ),
    );
  }

  Widget _buildPalindromeList(List<Palindrome> palindromes) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      physics: const BouncingScrollPhysics(),
      itemCount: palindromes.length,
      itemBuilder: (context, index) {
        final palindrome = palindromes[index];
        Color? backgroundColor;
        IconData? icon;

        if (palindrome.isPurePalindrome && palindrome.isPalindrome) {
          backgroundColor = Colors.greenAccent;
          icon = Icons.check_circle_sharp;
        } else if (!palindrome.isPurePalindrome && palindrome.isPalindrome) {
          backgroundColor = Colors.yellowAccent;
          icon = Icons.check_circle_outlined;
        } else {
          backgroundColor = Colors.redAccent.shade200;
          icon = Icons.cancel;
        }

        return Container(
          key: const Key(Constants.str_mainContainerKey),
          color: backgroundColor,
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(
              palindrome.text,
              style: GoogleFonts.abhayaLibre(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4.0),
                Text(
                  '${Constants.str_purePalindrome}: ${palindrome.isPurePalindrome}',
                  style: TextStyle(
                    fontSize: 14,
                    color: backgroundColor,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  '${Constants.str_palindrome}: ${palindrome.isPalindrome}',
                  style: TextStyle(
                    fontSize: 14,
                    color: backgroundColor,
                  ),
                ),
              ],
            ),
            trailing: Icon(
              icon,
              color: backgroundColor,
            ),
          ),
        );
      },
    );
  }
}
