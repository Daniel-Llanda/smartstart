import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

// Import your actual pages
import 'four/colors_page.dart';
import 'four/shapes_page.dart';
import 'four/numbers_page.dart';
import 'four/alphabets_page.dart';
import 'four/animals_page.dart';
import 'four/bodyparts_page.dart';

class NumberFourScreen extends StatefulWidget {
  final String selectedLanguage;

  const NumberFourScreen({super.key, required this.selectedLanguage});

  @override
  State<NumberFourScreen> createState() => _NumberFourScreenState();
}

class _NumberFourScreenState extends State<NumberFourScreen> {
  final FlutterTts flutterTts = FlutterTts();

  String getText() {
    return widget.selectedLanguage == 'Tagalog'
        ? 'Apat na taong gulang'
        : 'Four years old';
  }

  Future<void> _speakText(String text) async {
    await flutterTts.setLanguage(
      widget.selectedLanguage == 'Tagalog' ? 'tl-PH' : 'en-US',
    );
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  List<Map<String, dynamic>> getTranslatedButtons() {
    final isTagalog = widget.selectedLanguage == 'Tagalog';

    return [
      {
        'title': isTagalog ? 'Kulay' : 'Colors',
        'color': Colors.pinkAccent.shade100,
        'image': 'assets/images/colors.png',
      },
      {
        'title': isTagalog ? 'Hugis' : 'Shapes',
        'color': Colors.lightBlueAccent.shade100,
        'image': 'assets/images/shapes.png',
      },
      {
        'title': isTagalog ? 'Numero' : 'Number',
        'color': Colors.amberAccent.shade100,
        'image': 'assets/images/numbers.png',
      },
      {
        'title': isTagalog ? 'Alpabeto' : 'Alphabet',
        'color': Colors.redAccent.shade100,
        'image': 'assets/images/alphabets.png',
      },
      {
        'title': isTagalog ? 'Hayop' : 'Animals',
        'color': Colors.blueAccent.shade100,
        'image': 'assets/images/animals.png',
      },
      {
        'title': isTagalog ? 'Parte ng Katawan' : 'Body Part',
        'color': Colors.purpleAccent.shade100,
        'image': 'assets/images/bodyparts.png',
      },
    ];
  }

  Widget getPage(String title) {
    switch (title) {
      case 'Colors':
      case 'Kulay':
        return ColorsPage(language: widget.selectedLanguage);
      case 'Shapes':
      case 'Hugis':
        return ShapesPage(language: widget.selectedLanguage);
      case 'Number':
      case 'Numero':
        return NumbersPage(language: widget.selectedLanguage);
      case 'Alphabet':
      case 'Alpabeto':
        return AlphabetsPage(language: widget.selectedLanguage);
      case 'Animals':
      case 'Hayop':
        return AnimalsPage(language: widget.selectedLanguage);
      case 'Body Part':
      case 'Parte ng Katawan':
        return BodyPartsPage(language: widget.selectedLanguage);
      default:
        return const Scaffold(body: Center(child: Text('Page not found')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttons = getTranslatedButtons();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/four.png', fit: BoxFit.cover),
          ),
          Positioned(
            top: 40,
            left: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.deepPurple,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 80),
                Center(
                  child: GestureDetector(
                    onTap: () => _speakText(getText()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        getText(),
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Wrap(
                  spacing: 20,
                  runSpacing: 30,
                  alignment: WrapAlignment.center,
                  children:
                      buttons.map((btn) {
                        final Color bgColor = btn['color'] as Color;

                        return Column(
                          children: [
                            SizedBox(
                              width: 120,
                              height: 120,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: bgColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  elevation: 6,
                                  shadowColor: bgColor,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => getPage(btn['title']),
                                    ),
                                  );
                                },
                                child: Image.asset(btn['image'], height: 50),
                              ),
                            ),
                            const SizedBox(height: 6),
                            GestureDetector(
                              onTap: () => _speakText(btn['title']),
                              child: Container(
                                width: 120,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: bgColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  btn['title'],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
