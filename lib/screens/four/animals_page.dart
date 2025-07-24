import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class AnimalsPage extends StatelessWidget {
  final String language;

  const AnimalsPage({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    final FlutterTts flutterTts = FlutterTts();

    final items = [
      {
        'label': language == 'Tagalog' ? 'Aso' : 'Dog',
        'image': 'assets/images/animals/dog.png',
      },
      {
        'label': language == 'Tagalog' ? 'Pusa' : 'Cat',
        'image': 'assets/images/animals/cat.png',
      },
      {
        'label': language == 'Tagalog' ? 'Ibon' : 'Bird',
        'image': 'assets/images/animals/bird.png',
      },
      {
        'label': language == 'Tagalog' ? 'Isda' : 'Fish',
        'image': 'assets/images/animals/fish.png',
      },
      {
        'label': language == 'Tagalog' ? 'Kabayo' : 'Horse',
        'image': 'assets/images/animals/horse.png',
      },
      {
        'label': language == 'Tagalog' ? 'Tigre' : 'Tiger',
        'image': 'assets/images/animals/tiger.png',
      },
      {
        'label': language == 'Tagalog' ? 'Elepante' : 'Elephant',
        'image': 'assets/images/animals/elephant.png',
      },
      {
        'label': language == 'Tagalog' ? 'Unggoy' : 'Monkey',
        'image': 'assets/images/animals/monkey.png',
      },
      {
        'label': language == 'Tagalog' ? 'Ahas' : 'Snake',
        'image': 'assets/images/animals/snake.png',
      },
      {
        'label': language == 'Tagalog' ? 'Pagong' : 'Turtle',
        'image': 'assets/images/animals/turtle.png',
      },
      {
        'label': language == 'Tagalog' ? 'Balyena' : 'Whale',
        'image': 'assets/images/animals/whale.png',
      },
      {
        'label': language == 'Tagalog' ? 'Agila' : 'Eagle',
        'image': 'assets/images/animals/eagle.png',
      },
      {
        'label': language == 'Tagalog' ? 'Paniki' : 'Bat',
        'image': 'assets/images/animals/bat.png',
      },
      {
        'label': language == 'Tagalog' ? 'Pating' : 'Shark',
        'image': 'assets/images/animals/shark.png',
      },
      {
        'label': language == 'Tagalog' ? 'Baboy' : 'Pig',
        'image': 'assets/images/animals/pig.png',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(language == 'Tagalog' ? 'Mga Hayop' : 'Animals'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children:
            items.map((item) {
              final label = item['label'] as String;
              final image = item['image'] as String;

              return GestureDetector(
                onTap: () async {
                  await flutterTts.setLanguage(
                    language == 'Tagalog' ? 'tl-PH' : 'en-US',
                  );
                  await flutterTts.speak(label);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(image, height: 80),
                    const SizedBox(height: 8),
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
      ),
    );
  }
}
