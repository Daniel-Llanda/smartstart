import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class NumbersPage extends StatelessWidget {
  final String language;

  const NumbersPage({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    final FlutterTts flutterTts = FlutterTts();

    final numbers = List.generate(20, (i) => i + 1);
    final labels =
        language == 'Tagalog'
            ? [
              'Isa',
              'Dalawa',
              'Tatlo',
              'Apat',
              'Lima',
              'Anim',
              'Pito',
              'Walo',
              'Siyam',
              'Sampu',
              'Labing-isa',
              'Labindalawa',
              'Labintatlo',
              'Labing-apat',
              'Labinlima',
              'Labing-anim',
              'Labimpito',
              'Labing-walo',
              'Labinsiyam',
              'Dalawampu',
            ]
            : [
              'One',
              'Two',
              'Three',
              'Four',
              'Five',
              'Six',
              'Seven',
              'Eight',
              'Nine',
              'Ten',
              'Eleven',
              'Twelve',
              'Thirteen',
              'Fourteen',
              'Fifteen',
              'Sixteen',
              'Seventeen',
              'Eighteen',
              'Nineteen',
              'Twenty',
            ];

    return Scaffold(
      appBar: AppBar(
        title: Text(language == 'Tagalog' ? 'Mga Numero' : 'Numbers'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: GridView.count(
        crossAxisCount: 3,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: List.generate(numbers.length, (index) {
          return GestureDetector(
            onTap: () async {
              await flutterTts.setLanguage(
                language == 'Tagalog' ? 'tl-PH' : 'en-US',
              );
              await flutterTts.speak(labels[index]);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.teal.shade200,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      numbers[index].toString(), // Number (e.g., 1)
                      style: const TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      labels[index],
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
