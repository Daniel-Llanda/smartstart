import 'dart:ui';
import 'package:flutter/material.dart';

class BodyPartsPage extends StatelessWidget {
  final int ageValue;
  final String selectedLanguage;

  const BodyPartsPage({
    super.key,
    required this.ageValue,
    required this.selectedLanguage,
  });

  /// 🧍 Body parts data based on age
  List<Map<String, String>> getBodyPartsByAge() {
    final allParts = [
      {'eng': 'Eyes', 'tag': 'Mata'},
      {'eng': 'Nose', 'tag': 'Ilong'},
      {'eng': 'Mouth', 'tag': 'Bibig'},
      {'eng': 'Hands', 'tag': 'Kamay'},
      {'eng': 'Feet', 'tag': 'Paa'},
      {'eng': 'Ear', 'tag': 'Tainga'},
      {'eng': 'Arms', 'tag': 'Braso'},
      {'eng': 'Leg', 'tag': 'Binti'},
      {'eng': 'Brain', 'tag': 'Utak'},
      {'eng': 'Back', 'tag': 'Likod'},
      {'eng': 'Toes', 'tag': 'Daliri sa Paa'},
      {'eng': 'Knee', 'tag': 'Tuhod'},
      {'eng': 'Elbow', 'tag': 'Siko'},
      {'eng': 'Neck', 'tag': 'Leeg'},
      {'eng': 'Shoulders', 'tag': 'Balikat'},
    ];

    if (ageValue == 2) {
      return allParts.take(5).toList();
    } else if (ageValue == 3) {
      return allParts.take(10).toList();
    } else {
      return allParts.take(15).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bodyParts = getBodyPartsByAge();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          selectedLanguage == 'Tagalog'
              ? 'Parte ng Katawan'
              : 'Body Parts',
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

          /// 🧍 Body Parts Grid with Images
          Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              itemCount: bodyParts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final part = bodyParts[index];
                final label = selectedLanguage == 'Tagalog'
                    ? part['tag']
                    : part['eng'];

                // Use lowercase English name for image filename
                final imagePath =
                    'assets/images/body_parts/${part['eng']!.toLowerCase()}.png';

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
                      SizedBox(
                        height: 100, // fixed image height
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        label!,
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
