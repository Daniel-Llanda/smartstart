import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

// Import the category pages with aliases
import 'alphabets_page.dart';
import 'animals_page.dart';
import 'shapes_page.dart' as shape_page;
import 'colors_page.dart' as color_page;
import 'numbers_page.dart';
import 'bodyparts_page.dart';

/// 🟦 Age 2 Completion Flags
bool colorGameAgeTwoCompleted = false;
bool shapeGameAgeTwoCompleted = false;
bool numberGameAgeTwoCompleted = false;
bool bodypartGameAgeTwoCompleted = false;
bool animalGameAgeTwoCompleted = false;
bool alphabetGameAgeTwoCompleted = false;

/// 🟩 Age 3 Completion Flags
bool colorGameAgeThreeCompleted = false;
bool shapeGameAgeThreeCompleted = false;
bool numberGameAgeThreeCompleted = false;
bool bodypartGameAgeThreeCompleted = false;
bool animalGameAgeThreeCompleted = false;
bool alphabetGameAgeThreeCompleted = false;

/// 🟧 Age 4 Completion Flags
bool colorGameAgeFourCompleted = false;
bool shapeGameAgeFourCompleted = false;
bool numberGameAgeFourCompleted = false;
bool bodypartGameAgeFourCompleted = false;
bool animalGameAgeFourCompleted = false;
bool alphabetGameAgeFourCompleted = false;

class UniversalAgeScreen extends StatefulWidget {
  final String selectedLanguage;
  final int ageValue;

  const UniversalAgeScreen({
    super.key,
    required this.selectedLanguage,
    required this.ageValue,
  });

  @override
  State<UniversalAgeScreen> createState() => _UniversalAgeScreenState();
}

class _UniversalAgeScreenState extends State<UniversalAgeScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  int getCompletedStars() {
    int count = 0;
    switch (widget.ageValue) {
      case 2:
        if (colorGameAgeTwoCompleted) count++;
        if (shapeGameAgeTwoCompleted) count++;
        if (numberGameAgeTwoCompleted) count++;
        if (bodypartGameAgeTwoCompleted) count++;
        if (animalGameAgeTwoCompleted) count++;
        if (alphabetGameAgeTwoCompleted) count++;
        break;
      case 3:
        if (colorGameAgeThreeCompleted) count++;
        if (shapeGameAgeThreeCompleted) count++;
        if (numberGameAgeThreeCompleted) count++;
        if (bodypartGameAgeThreeCompleted) count++;
        if (animalGameAgeThreeCompleted) count++;
        if (alphabetGameAgeThreeCompleted) count++;
        break;
      case 4:
        if (colorGameAgeFourCompleted) count++;
        if (shapeGameAgeFourCompleted) count++;
        if (numberGameAgeFourCompleted) count++;
        if (bodypartGameAgeFourCompleted) count++;
        if (animalGameAgeFourCompleted) count++;
        if (alphabetGameAgeFourCompleted) count++;
        break;
    }
    return count;
  }

  String getDisplayText() {
    return widget.selectedLanguage == 'Tagalog'
        ? 'Ang iyong edad ay ${widget.ageValue}'
        : 'Your age is ${widget.ageValue}';
  }

  Future<void> playSound(String category) async {
    try {
      String langFolder = widget.selectedLanguage == 'Tagalog'
          ? 'assets/sounds/category/l_tag/'
          : 'assets/sounds/category/l_eng/';

      final Map<String, String> tagalogFiles = {
        'color': 'kulay.m4a',
        'shapes': 'hugis.m4a',
        'alphabets': 'letra.m4a',
        'animals': 'hayop.m4a',
        'numbers': 'numero.m4a',
        'bodyparts': 'parte_ng_katawan.m4a',
      };

      final Map<String, String> englishFiles = {
        'color': 'colors.m4a',
        'shapes': 'shapes.m4a',
        'alphabets': 'letters.m4a',
        'animals': 'animals.m4a',
        'numbers': 'numbers.m4a',
        'bodyparts': 'bodyparts.m4a',
      };

      final fileName = widget.selectedLanguage == 'Tagalog'
          ? tagalogFiles[category]
          : englishFiles[category];

      if (fileName == null) return;

      await _audioPlayer.stop();
      await _audioPlayer.play(
        AssetSource('${langFolder.replaceFirst('assets/', '')}$fileName'),
      );
    } catch (e) {
      debugPrint('Error playing sound: $e');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void openCategory(String category) {
    Widget page;
    switch (category) {
      case 'alphabets':
        page = AlphabetsPage(
          ageValue: widget.ageValue,
          selectedLanguage: widget.selectedLanguage,
        );
        break;
      case 'animals':
        page = AnimalsPage(
          ageValue: widget.ageValue,
          selectedLanguage: widget.selectedLanguage,
        );
        break;
      case 'shapes':
        page = shape_page.ShapesPage(
          ageValue: widget.ageValue,
          selectedLanguage: widget.selectedLanguage,
        );
        break;
      case 'color':
        page = color_page.ColorsPage(
          ageValue: widget.ageValue,
          selectedLanguage: widget.selectedLanguage,
        );
        break;
      case 'numbers':
        page = NumbersPage(
          ageValue: widget.ageValue,
          selectedLanguage: widget.selectedLanguage,
        );
        break;
      case 'bodyparts':
        page = BodyPartsPage(
          ageValue: widget.ageValue,
          selectedLanguage: widget.selectedLanguage,
        );
        break;
      default:
        return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        'labelEng': 'Colors',
        'labelTag': 'Kulay',
        'name': 'color',
        'color': Colors.orangeAccent.shade100,
      },
      {
        'labelEng': 'Shapes',
        'labelTag': 'Mga Hugis',
        'name': 'shapes',
        'color': Colors.purpleAccent.shade100,
      },
      {
        'labelEng': 'Alphabets',
        'labelTag': 'Alpabeto',
        'name': 'alphabets',
        'color': Colors.yellow.shade200,
      },
      {
        'labelEng': 'Animals',
        'labelTag': 'Hayop',
        'name': 'animals',
        'color': Colors.lightBlueAccent.shade100,
      },
      {
        'labelEng': 'Numbers',
        'labelTag': 'Numero',
        'name': 'numbers',
        'color': Colors.greenAccent.shade100,
      },
      {
        'labelEng': 'Body Parts',
        'labelTag': 'Parte ng Katawan',
        'name': 'bodyparts',
        'color': Colors.pinkAccent.shade100,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          getDisplayText(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final label = widget.selectedLanguage == 'Tagalog'
                    ? item['labelTag']
                    : item['labelEng'];

                bool isCompleted = false;
                switch (widget.ageValue) {
                  case 2:
                    if (item['name'] == 'color') isCompleted = colorGameAgeTwoCompleted;
                    if (item['name'] == 'shapes') isCompleted = shapeGameAgeTwoCompleted;
                    if (item['name'] == 'numbers') isCompleted = numberGameAgeTwoCompleted;
                    if (item['name'] == 'bodyparts') isCompleted = bodypartGameAgeTwoCompleted;
                    if (item['name'] == 'animals') isCompleted = animalGameAgeTwoCompleted;
                    if (item['name'] == 'alphabets') isCompleted = alphabetGameAgeTwoCompleted;
                    break;
                  case 3:
                    if (item['name'] == 'color') isCompleted = colorGameAgeThreeCompleted;
                    if (item['name'] == 'shapes') isCompleted = shapeGameAgeThreeCompleted;
                    if (item['name'] == 'numbers') isCompleted = numberGameAgeThreeCompleted;
                    if (item['name'] == 'bodyparts') isCompleted = bodypartGameAgeThreeCompleted;
                    if (item['name'] == 'animals') isCompleted = animalGameAgeThreeCompleted;
                    if (item['name'] == 'alphabets') isCompleted = alphabetGameAgeThreeCompleted;
                    break;
                  case 4:
                    if (item['name'] == 'color') isCompleted = colorGameAgeFourCompleted;
                    if (item['name'] == 'shapes') isCompleted = shapeGameAgeFourCompleted;
                    if (item['name'] == 'numbers') isCompleted = numberGameAgeFourCompleted;
                    if (item['name'] == 'bodyparts') isCompleted = bodypartGameAgeFourCompleted;
                    if (item['name'] == 'animals') isCompleted = animalGameAgeFourCompleted;
                    if (item['name'] == 'alphabets') isCompleted = alphabetGameAgeFourCompleted;
                    break;
                }

                return GestureDetector(
                  onTap: () => openCategory(item['name']),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: item['color'], width: 3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            label,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        if (isCompleted)
                          const Icon(Icons.check, size: 28, color: Colors.black),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => playSound(item['name']),
                          child: const Icon(
                            Icons.volume_up,
                            size: 28,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: Colors.grey.shade200,
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: getCompletedStars() / 6,
                  minHeight: 12,
                  backgroundColor: Colors.grey.shade400,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                ),
                const SizedBox(height: 6),
                Text(
                  "Stars collected: ${getCompletedStars()}/6",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade700,
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
