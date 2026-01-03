import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class BodyPartsPage extends StatefulWidget {
  final int ageValue;
  final String selectedLanguage;

  const BodyPartsPage({
    super.key,
    required this.ageValue,
    required this.selectedLanguage,
  });

  @override
  State<BodyPartsPage> createState() => _BodyPartsPageState();
}

class _BodyPartsPageState extends State<BodyPartsPage> {
  final AudioPlayer _player = AudioPlayer();

  /// Normalize text → filename
  String _normalize(String text) {
    return text.toLowerCase().replaceAll(' ', '-');
  }

  /// 🔊 Play body part audio
  Future<void> _playAudio(String eng, String tag) async {
    try {
      final folder = widget.selectedLanguage == 'Tagalog'
          ? 'sounds/bodyparts/tag/'
          : 'sounds/bodyparts/eng/';

      final fileName = widget.selectedLanguage == 'Tagalog'
          ? '${_normalize(tag)}.m4a'
          : '${_normalize(eng)}.m4a';

      await _player.stop();
      await _player.play(
        AssetSource('$folder$fileName'),
      );
    } catch (e) {
      debugPrint('Body part audio error: $e');
    }
  }

  /// 🧍 Body parts by age
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

    if (widget.ageValue == 2) {
      return allParts.take(5).toList();
    } else if (widget.ageValue == 3) {
      return allParts.take(10).toList();
    } else {
      return allParts.take(15).toList();
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
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
          widget.selectedLanguage == 'Tagalog'
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

          /// Glass blur
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(color: Colors.white.withOpacity(0.25)),
            ),
          ),

          /// 🧍 Body parts grid
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
                final eng = part['eng']!;
                final tag = part['tag']!;
                final label =
                    widget.selectedLanguage == 'Tagalog' ? tag : eng;

                final imagePath =
                    'assets/images/body_parts/${_normalize(eng)}.png';

                return GestureDetector(
                  onTap: () => _playAudio(eng, tag),
                  child: Container(
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
                          height: 100,
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          label,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
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
