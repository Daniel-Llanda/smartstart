import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AnimalsPage extends StatefulWidget {
  final int ageValue;
  final String selectedLanguage;

  const AnimalsPage({
    super.key,
    required this.ageValue,
    required this.selectedLanguage,
  });

  @override
  State<AnimalsPage> createState() => _AnimalsPageState();
}

class _AnimalsPageState extends State<AnimalsPage> {
  final AudioPlayer _player = AudioPlayer();

  /// 🐾 Animal data: Tagalog -> English
  final Map<String, String> animalsMap = const {
    'Aso': 'Dog',
    'Pusa': 'Cat',
    'Ibon': 'Bird',
    'Kabayo': 'Horse',
    'Isda': 'Fish',
    'Tigre': 'Tiger',
    'Elepante': 'Elephant',
    'Unggoy': 'Monkey',
    'Ahas': 'Snake',
    'Pagong': 'Turtle',
    'Balyena': 'Whale',
    'Agila': 'Eagle',
    'Paniki': 'Bat',
    'Pating': 'Shark',
    'Baboy': 'Pig',
  };

  /// 🧼 Normalize text → filename
  String _normalize(String text) {
    return text.toLowerCase().replaceAll(' ', '-');
  }

  /// 🔊 Play animal audio
  Future<void> _playAnimalAudio(String tagalog, String english) async {
    try {
      final folder = widget.selectedLanguage == 'Tagalog'
          ? 'sounds/animals/tag/'
          : 'sounds/animals/eng/';

      final fileName = widget.selectedLanguage == 'Tagalog'
          ? '${_normalize(tagalog)}.m4a'
          : '${_normalize(english)}.m4a';

      await _player.stop();
      await _player.play(AssetSource('$folder$fileName'));
    } catch (e) {
      debugPrint('Animal audio error: $e');
    }
  }

  /// 🐾 Get animals based on age
  List<Map<String, String>> getAnimals() {
    int count = widget.ageValue == 2
        ? 5
        : widget.ageValue == 3
            ? 10
            : 15;

    return animalsMap.entries
        .take(count)
        .map((e) => {'tagalog': e.key, 'english': e.value})
        .toList();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animals = getAnimals();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.tealAccent.shade700,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          widget.selectedLanguage == 'Tagalog' ? 'Mga Hayop' : 'Animals',
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
              itemCount: animals.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final animal = animals[index];
                final tagalog = animal['tagalog']!;
                final english = animal['english']!;
                final displayName = widget.selectedLanguage == 'Tagalog'
                    ? tagalog
                    : english;

                return GestureDetector(
                  onTap: () => _playAnimalAudio(tagalog, english),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.tealAccent.shade700,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Center(
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.asset(
                                'assets/images/animals/${english.toLowerCase()}.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),
                        Text(
                          displayName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                      ],
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
