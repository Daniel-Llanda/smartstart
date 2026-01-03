import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AlphabetsPage extends StatefulWidget {
  final int ageValue;
  final String selectedLanguage;

  const AlphabetsPage({
    super.key,
    required this.ageValue,
    required this.selectedLanguage,
  });

  @override
  State<AlphabetsPage> createState() => _AlphabetsPageState();
}

class _AlphabetsPageState extends State<AlphabetsPage> {
  final AudioPlayer _player = AudioPlayer();

  /// 🔤 Get alphabets based on age
  List<String> getAlphabetsByAge() {
    const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

    int max;
    if (widget.ageValue == 2) {
      max = 8; // A–H
    } else if (widget.ageValue == 3) {
      max = 17; // A–Q
    } else {
      max = 26; // A–Z
    }

    return alphabet.substring(0, max).split('');
  }

  /// 🔊 Play alphabet audio (same for all languages)
  Future<void> _playAlphabetAudio(String letter) async {
    try {
      final fileName = '${letter.toLowerCase()}.m4a';

      await _player.stop();
      await _player.play(
        AssetSource('sounds/alphabets/$fileName'),
      );
    } catch (e) {
      debugPrint('Alphabet audio error: $e');
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
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
          widget.selectedLanguage == 'Tagalog' ? 'Alpabeto' : 'Alphabets',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/one.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(color: Colors.white.withOpacity(0.25)),
            ),
          ),
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

                return GestureDetector(
                  onTap: () => _playAlphabetAudio(letter),
                  child: Container(
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
                      padding: const EdgeInsets.all(16),
                      child: Image.asset(
                        'assets/images/alphabets/$letter.jpg',
                        fit: BoxFit.contain,
                      ),
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
