import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palindrome_with_provider/constants.dart';
import 'package:palindrome_with_provider/palindrome.dart';
import 'package:palindrome_with_provider/palindrome_provider.dart';
import 'package:provider/provider.dart';

class PalindromeListPage extends StatelessWidget {
  const PalindromeListPage({super.key});

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
        backgroundColor: Colors.deepOrange.withOpacity(0.6),
      ),
      body: Consumer<PalindromeProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return _buildPalindromeList(provider.palindromes);
          }
        },
      ),
    );
  }

  Widget _buildPalindromeList(List<Palindrome> palindromes) {
    return ListView.builder(
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
                fontSize: 17,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4.0),
                Text(
                  '${Constants.str_purePalindrome}: ${palindrome.isPurePalindrome}',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  '${Constants.str_palindrome}: ${palindrome.isPalindrome}',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            trailing: Icon(icon),
          ),
        );
      },
    );
  }
}
