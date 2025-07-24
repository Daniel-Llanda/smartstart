import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'screens/two_years_old.dart';
import 'screens/three_years_old.dart';
import 'screens/four_years_old.dart';

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
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();

    flutterTts.getLanguages.then((languages) {
      print('📢 Available TTS languages:');
      for (var lang in languages) {
        print(lang);
      }
    });
  }

  String getQuestionText() {
    return selectedLanguage == 'Tagalog'
        ? 'Ilan taon ka na?'
        : "How old are you?";
  }

  Future<void> _speak(String text) async {
    String langCode = selectedLanguage == 'Tagalog' ? 'tl-PH' : 'en-US';

    bool isSupported = await flutterTts.isLanguageAvailable(langCode);

    if (isSupported) {
      await flutterTts.setLanguage(langCode);
    } else {
      print('Language $langCode not supported, falling back to English.');
      await flutterTts.setLanguage('en-US');
    }

    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.45); // Optional: make it sound smoother
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/one.png', fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => _speak(getQuestionText()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        getQuestionText(),
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      // Button for age 2
                      Column(
                        children: [
                          SizedBox(
                            width: 140,
                            height: 140,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orangeAccent.shade200,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                elevation: 6,
                                shadowColor: Colors.orangeAccent.shade200
                                    .withOpacity(0.6),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => NumberTwoScreen(
                                          selectedLanguage: selectedLanguage,
                                        ),
                                  ),
                                );
                              },
                              child: const Text(
                                '2',
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 4,
                                      color: Colors.black26,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          GestureDetector(
                            onTap:
                                () => _speak(
                                  selectedLanguage == 'Tagalog'
                                      ? 'Dalawa'
                                      : 'Two',
                                ),
                            child: Container(
                              width: 140,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orangeAccent.shade200,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                selectedLanguage == 'Tagalog'
                                    ? 'Dalawa'
                                    : 'Two',
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
                      ),

                      // Button for age 3
                      Column(
                        children: [
                          SizedBox(
                            width: 140,
                            height: 140,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent.shade400,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                elevation: 6,
                                shadowColor: Colors.blueAccent.shade400
                                    .withOpacity(0.6),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => NumberThreeScreen(
                                          selectedLanguage: selectedLanguage,
                                        ),
                                  ),
                                );
                              },
                              child: const Text(
                                '3',
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 4,
                                      color: Colors.black26,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          GestureDetector(
                            onTap:
                                () => _speak(
                                  selectedLanguage == 'Tagalog'
                                      ? 'Tatlo'
                                      : 'Three',
                                ),
                            child: Container(
                              width: 140,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent.shade400,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                selectedLanguage == 'Tagalog'
                                    ? 'Tatlo'
                                    : 'Three',
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
                      ),

                      // Button for age 4
                      Column(
                        children: [
                          SizedBox(
                            width: 140,
                            height: 140,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.greenAccent.shade400,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                elevation: 6,
                                shadowColor: Colors.greenAccent.shade400
                                    .withOpacity(0.6),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => NumberFourScreen(
                                          selectedLanguage: selectedLanguage,
                                        ),
                                  ),
                                );
                              },
                              child: const Text(
                                '4',
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 4,
                                      color: Colors.black26,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          GestureDetector(
                            onTap:
                                () => _speak(
                                  selectedLanguage == 'Tagalog'
                                      ? 'Apat'
                                      : 'Four',
                                ),
                            child: Container(
                              width: 140,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.greenAccent.shade400,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                selectedLanguage == 'Tagalog' ? 'Apat' : 'Four',
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: DropdownButton<String>(
                value: selectedLanguage,
                icon: const Icon(Icons.language, color: Colors.deepPurple),
                dropdownColor: Colors.white,
                underline: const SizedBox(),
                style: const TextStyle(color: Colors.black),
                items:
                    <String>['English', 'Tagalog'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                onChanged: (String? newLang) {
                  if (newLang != null) {
                    setState(() {
                      selectedLanguage = newLang;
                    });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
