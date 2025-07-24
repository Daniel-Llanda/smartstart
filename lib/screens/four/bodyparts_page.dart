import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class BodyPartsPage extends StatelessWidget {
  final String language;

  const BodyPartsPage({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    final FlutterTts flutterTts = FlutterTts();

    final items = [
      {
        'label': language == 'Tagalog' ? 'Mata' : 'Eyes',
        'image': 'assets/images/body_parts/eyes.png',
      },
      {
        'label': language == 'Tagalog' ? 'Ilong' : 'Nose',
        'image': 'assets/images/body_parts/nose.png',
      },
      {
        'label': language == 'Tagalog' ? 'Bibig' : 'Mouth',
        'image': 'assets/images/body_parts/mouth.png',
      },
      {
        'label': language == 'Tagalog' ? 'Kamay' : 'Hands',
        'image': 'assets/images/body_parts/hands.png',
      },
      {
        'label': language == 'Tagalog' ? 'Paa' : 'Feet',
        'image': 'assets/images/body_parts/feet.png',
      },
      {
        'label': language == 'Tagalog' ? 'Tenga' : 'Ears',
        'image': 'assets/images/body_parts/ear.png',
      },
      {
        'label': language == 'Tagalog' ? 'Braso' : 'Arms',
        'image': 'assets/images/body_parts/arms.png',
      },
      {
        'label': language == 'Tagalog' ? 'Binti' : 'Legs',
        'image': 'assets/images/body_parts/leg.png',
      },
      {
        'label': language == 'Tagalog' ? 'Utak' : 'Brain',
        'image': 'assets/images/body_parts/brain.png',
      },
      {
        'label': language == 'Tagalog' ? 'Likod' : 'Back',
        'image': 'assets/images/body_parts/back.png',
      },
      {
        'label': language == 'Tagalog' ? 'Daliri sa Paa' : 'Toes',
        'image': 'assets/images/body_parts/toes.png',
      },
      {
        'label': language == 'Tagalog' ? 'Tuhod' : 'Knees',
        'image': 'assets/images/body_parts/knee.png',
      },
      {
        'label': language == 'Tagalog' ? 'Siko' : 'Elbows',
        'image': 'assets/images/body_parts/elbow.png',
      },
      {
        'label': language == 'Tagalog' ? 'Leeg' : 'Neck',
        'image': 'assets/images/body_parts/neck.png',
      },
      {
        'label': language == 'Tagalog' ? 'Balikat' : 'Shoulders',
        'image': 'assets/images/body_parts/shoulders.png',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(language == 'Tagalog' ? 'Parte ng Katawan' : 'Body Parts'),
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
