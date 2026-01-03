import 'dart:ui';
import 'package:flutter/material.dart';

class AlphabetsPage extends StatelessWidget {
  final int ageValue;
  final String selectedLanguage;

  const AlphabetsPage({
    super.key,
    required this.ageValue,
    required this.selectedLanguage,
  });

  /// 🔤 Get alphabets based on age
  List<String> getAlphabetsByAge() {
    const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

    int max;

    if (ageValue == 2) {
      max = 8; // A–H
    } else if (ageValue == 3) {
      max = 17; // A–Q
    } else {
      max = 26; // A–Z
    }

    return alphabet.substring(0, max).split('');
  }

  @override
  Widget build(BuildContext context) {
    final letters = getAlphabetsByAge();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          selectedLanguage == 'Tagalog' ? 'Alpabeto' : 'Alphabets',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          /// Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/one.png',
              fit: BoxFit.cover,
            ),
          ),

          /// Glass effect
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(color: Colors.white.withOpacity(0.25)),
            ),
          ),

          /// 🔤 Alphabet Grid with Images
          Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              itemCount: letters.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final letter = letters[index];
                final imagePath = 'assets/images/alphabets/$letter.jpg';

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(2, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
