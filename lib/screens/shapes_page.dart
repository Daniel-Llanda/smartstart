import 'dart:ui';
import 'package:flutter/material.dart';

class ShapesPage extends StatelessWidget {
  final int ageValue;
  final String selectedLanguage;

  const ShapesPage({
    super.key,
    required this.ageValue,
    required this.selectedLanguage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.withOpacity(0.85),
        title: Text(
          selectedLanguage == 'Tagalog'
              ? 'Shapes'
              : 'Hugis',
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/one.png',
              fit: BoxFit.cover,
            ),
          ),

          // Glass effect
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                color: Colors.white.withOpacity(0.25),
              ),
            ),
          ),

          // Content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  selectedLanguage == 'Tagalog'
                      ? 'Edad: $ageValue'
                      : 'Age: $ageValue',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  selectedLanguage == 'Tagalog'
                      ? 'Dito ilalagay ang alpabeto game'
                      : 'Alphabet game goes here',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
