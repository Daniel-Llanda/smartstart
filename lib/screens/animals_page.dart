import 'dart:ui';
import 'package:flutter/material.dart';

class AnimalsPage extends StatelessWidget {
  final int ageValue;
  final String selectedLanguage;

  const AnimalsPage({
    super.key,
    required this.ageValue,
    required this.selectedLanguage,
  });

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

  /// 🐾 Get animals based on age
  List<Map<String, String>> getAnimals() {
    int count;
    if (ageValue == 2) {
      count = 5;
    } else if (ageValue == 3) {
      count = 10;
    } else {
      count = 15;
    }

    // Take the first `count` animals
    final entries = animalsMap.entries.take(count);

    // Convert to list of maps: { 'tagalog': ..., 'english': ... }
    return entries
        .map((e) => {'tagalog': e.key, 'english': e.value})
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final animals = getAnimals();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          selectedLanguage == 'Tagalog' ? 'Mga Hayop' : 'Animals',
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

          /// 🐾 Animals Grid with Images
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
                final displayName = selectedLanguage == 'Tagalog'
                    ? animal['tagalog']!
                    : animal['english']!;
                final imagePath =
                    'assets/images/animals/${animal['english']!.toLowerCase()}.png';

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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        displayName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                    ],
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
