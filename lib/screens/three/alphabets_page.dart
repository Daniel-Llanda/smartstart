import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class AlphabetsPage extends StatelessWidget {
  final String language;

  const AlphabetsPage({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    final FlutterTts flutterTts = FlutterTts();

    final englishLetters = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
    ];
    final tagalogLetters = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
    ];

    final items = List.generate(17, (index) {
      final letter =
          language == 'Tagalog' ? tagalogLetters[index] : englishLetters[index];

      return {
        'label': letter,
        'color': Colors.primaries[index % Colors.primaries.length],
      };
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(language == 'Tagalog' ? 'Mga Titik' : 'Alphabets'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: GridView.count(
        crossAxisCount: 3,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children:
            items.map((item) {
              final label = item['label'] as String;
              final color = item['color'] as Color;

              return GestureDetector(
                onTap: () async {
                  await flutterTts.setLanguage(
                    language == 'Tagalog' ? 'tl-PH' : 'en-US',
                  );
                  await flutterTts.speak(label);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
