import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'screens/universal.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedLanguage = 'English';
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playSound() async {
    final soundPath = selectedLanguage == 'Tagalog'
        ? 'assets/sounds/landing/l_tag/ilan.m4a'
        : 'assets/sounds/landing/l_eng/how.m4a';

    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(
        AssetSource(soundPath.replaceFirst('assets/', '')),
      );
    } catch (e) {
      debugPrint("Error playing sound: $e");
    }
  }

  String getQuestionText() {
    return selectedLanguage == 'Tagalog'
        ? 'Ilan taon ka na?'
        : 'How old are you?';
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Container(
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: playSound,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.8),
                          width: 1.5,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(3, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            getQuestionText(),
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.volume_up,
                            color: Colors.deepPurple,
                            size: 26,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      _buildAgeButton(
                        context,
                        age: 2,
                        color: Colors.orangeAccent,
                        labelEng: 'Two',
                        labelTag: 'Dalawa',
                      ),
                      _buildAgeButton(
                        context,
                        age: 3,
                        color: Colors.blueAccent,
                        labelEng: 'Three',
                        labelTag: 'Tatlo',
                      ),
                      _buildAgeButton(
                        context,
                        age: 4,
                        color: Colors.greenAccent.shade400,
                        labelEng: 'Four',
                        labelTag: 'Apat',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 30,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withOpacity(0.8),
                  width: 1.5,
                ),
              ),
              child: DropdownButton<String>(
                value: selectedLanguage,
                underline: const SizedBox(),
                icon: const Icon(Icons.language, color: Colors.deepPurple),
                items: const [
                  DropdownMenuItem(value: 'English', child: Text('English')),
                  DropdownMenuItem(value: 'Tagalog', child: Text('Tagalog')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => selectedLanguage = value);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgeButton(
    BuildContext context, {
    required int age,
    required Color color,
    required String labelEng,
    required String labelTag,
  }) {
    Future<void> playLabelSound() async {
      final path = selectedLanguage == 'Tagalog'
          ? 'assets/sounds/landing/l_tag/${labelTag.toLowerCase()}.m4a'
          : 'assets/sounds/landing/l_eng/${labelEng.toLowerCase()}.m4a';

      try {
        await _audioPlayer.stop();
        await _audioPlayer.play(
          AssetSource(path.replaceFirst('assets/', '')),
        );
      } catch (e) {
        debugPrint("Error playing label sound: $e");
      }
    }

    return SizedBox(
      width: 140,
      height: 140,
      child: Stack(
        children: [
          Positioned.fill(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                side: const BorderSide(color: Colors.black, width: 2),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UniversalAgeScreen(
                      selectedLanguage: selectedLanguage,
                      ageValue: age,
                    ),
                  ),
                );
              },
              child: Text(
                '$age',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: playLabelSound,
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.volume_up, color: Colors.deepPurple),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
