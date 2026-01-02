import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

// Import category pages
// import 'alphabets_page.dart';
// import 'animals_page.dart';
// import 'shapes_page.dart' as shape_page;
// import 'colors_page.dart' as color_page;
// import 'numbers_page.dart';
// import 'bodyparts_page.dart';

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

  /// ⭐ Count completed categories
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

  String getBackgroundImage() {
    switch (widget.ageValue) {
      case 2:
        return 'assets/images/two.png';
      case 3:
        return 'assets/images/three.png';
      case 4:
        return 'assets/images/four.png';
      default:
        return 'assets/images/one.png';
    }
  }

  /// 🔊 Play category audio
  Future<void> playSound(String category) async {
    try {
      final langFolder = widget.selectedLanguage == 'Tagalog'
          ? 'assets/sounds/category/l_tag/'
          : 'assets/sounds/category/l_eng/';

      final tagalogFiles = {
        'color': 'kulay.m4a',
        'shapes': 'hugis.m4a',
        'alphabets': 'letra.m4a',
        'animals': 'hayop.m4a',
        'numbers': 'numero.m4a',
        'bodyparts': 'parte_ng_katawan.m4a',
      };

      final englishFiles = {
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
      debugPrint('Audio error: $e');
    }
  }

  /// 🔗 Open category page
  void openCategory(String category) {
    Widget page;

    // switch (category) {
    //   case 'alphabets':
    //     page = AlphabetsPage(
    //       ageValue: widget.ageValue,
    //       selectedLanguage: widget.selectedLanguage,
    //     );
    //     break;
    //   case 'animals':
    //     page = AnimalsPage(
    //       ageValue: widget.ageValue,
    //       selectedLanguage: widget.selectedLanguage,
    //     );
    //     break;
    //   case 'shapes':
    //     page = shape_page.ShapesPage(
    //       ageValue: widget.ageValue,
    //       selectedLanguage: widget.selectedLanguage,
    //     );
    //     break;
    //   case 'color':
    //     page = color_page.ColorsPage(
    //       ageValue: widget.ageValue,
    //       selectedLanguage: widget.selectedLanguage,
    //     );
    //     break;
    //   case 'numbers':
    //     page = NumbersPage(
    //       ageValue: widget.ageValue,
    //       selectedLanguage: widget.selectedLanguage,
    //     );
    //     break;
    //   case 'bodyparts':
    //     page = BodyPartsPage(
    //       ageValue: widget.ageValue,
    //       selectedLanguage: widget.selectedLanguage,
    //     );
    //     break;
    //   default:
    //     return;
    // }

    // Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'image': 'assets/images/colors.png',
        'labelEng': 'Colors',
        'labelTag': 'Kulay',
        'name': 'color',
      },
      {
        'image': 'assets/images/shapes.png',
        'labelEng': 'Shapes',
        'labelTag': 'Mga Hugis',
        'name': 'shapes',
      },
      {
        'image': 'assets/images/alphabets.png',
        'labelEng': 'Alphabets',
        'labelTag': 'Alpabeto',
        'name': 'alphabets',
      },
      {
        'image': 'assets/images/animals.png',
        'labelEng': 'Animals',
        'labelTag': 'Hayop',
        'name': 'animals',
      },
      {
        'image': 'assets/images/numbers.png',
        'labelEng': 'Numbers',
        'labelTag': 'Numero',
        'name': 'numbers',
      },
      {
        'image': 'assets/images/bodyparts.png',
        'labelEng': 'Body Parts',
        'labelTag': 'Parte ng Katawan',
        'name': 'bodyparts',
      },
    ];

    final colors = [
      Colors.orangeAccent,
      Colors.lightBlueAccent,
      Colors.pinkAccent,
      Colors.tealAccent,
      Colors.purpleAccent,
      Colors.blueAccent,
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text(
          getDisplayText(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    getBackgroundImage(),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                ),
                ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final label = widget.selectedLanguage == 'Tagalog'
                        ? item['labelTag']
                        : item['labelEng'];

                    return GestureDetector(
                      onTap: () => openCategory(item['name']),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: colors[index % colors.length],
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: colors[index % colors.length]
                                  .withOpacity(0.4),
                              blurRadius: 12,
                              offset: const Offset(4, 6),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              item['image'],
                              height: 45,
                              width: 45,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                label!,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.volume_up,
                                color: Colors.white,
                              ),
                              onPressed: () => playSound(item['name']),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.white.withOpacity(0.7),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: getCompletedStars() / 6,
                  minHeight: 12,
                  borderRadius: BorderRadius.circular(8),
                  backgroundColor: Colors.deepPurple.shade100,
                  valueColor: const AlwaysStoppedAnimation(Colors.deepPurple),
                ),
                const SizedBox(height: 6),
                Text(
                  'Stars collected: ${getCompletedStars()}/6',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
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
