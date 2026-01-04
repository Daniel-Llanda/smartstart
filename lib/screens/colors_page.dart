import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class ColorsPage extends StatefulWidget {
  final int ageValue;
  final String selectedLanguage;

  const ColorsPage({
    super.key,
    required this.ageValue,
    required this.selectedLanguage,
  });

  @override
  State<ColorsPage> createState() => _ColorsPageState();
}

class _ColorsPageState extends State<ColorsPage> {
  final AudioPlayer _player = AudioPlayer();

  /// 🎨 Normalize label → filename
  String _normalize(String text) {
    return text.toLowerCase().replaceAll(' ', '-');
  }

  /// 🔊 Play color audio
  Future<void> _playColorAudio(String eng, String tag) async {
    try {
      final folder = widget.selectedLanguage == 'Tagalog'
          ? 'sounds/colors/tag/'
          : 'sounds/colors/eng/';

      final fileName = widget.selectedLanguage == 'Tagalog'
          ? '${_normalize(tag)}.m4a'
          : '${_normalize(eng)}.m4a';

      await _player.stop();
      await _player.play(
        AssetSource('$folder$fileName'),
      );
    } catch (e) {
      debugPrint('Color audio error: $e');
    }
  }

  /// 🎨 Color data per age
  List<Map<String, dynamic>> getColorsByAge() {
    final allColors = [
      {'color': Colors.red, 'eng': 'Red', 'tag': 'Pula'},
      {'color': Colors.green, 'eng': 'Green', 'tag': 'Berde'},
      {'color': Colors.blue, 'eng': 'Blue', 'tag': 'Asul'},
      {'color': Colors.yellow, 'eng': 'Yellow', 'tag': 'Dilaw'},
      {'color': Colors.orange, 'eng': 'Orange', 'tag': 'Kahel'},
      {'color': Colors.black, 'eng': 'Black', 'tag': 'Itim'},
      {'color': Colors.purple, 'eng': 'Purple', 'tag': 'Lila'},
      {'color': Colors.pink, 'eng': 'Pink', 'tag': 'Rosas'},
      {'color': Colors.brown, 'eng': 'Brown', 'tag': 'Kayumanggi'},
      {'color': Colors.white, 'eng': 'White', 'tag': 'Puti'},
      {'color': Colors.grey, 'eng': 'Grey', 'tag': 'Abo'},
      {'color': const Color(0xFFFFD700), 'eng': 'Gold', 'tag': 'Ginto'},
    ];

    if (widget.ageValue == 2) {
      return allColors.take(4).toList();
    } else if (widget.ageValue == 3) {
      return allColors.take(8).toList();
    } else {
      return allColors.take(12).toList();
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = getColorsByAge();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          widget.selectedLanguage == 'Tagalog' ? 'Kulay' : 'Colors',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      // 🔽 ADD THIS
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(16),
      //   child: SizedBox(
      //     height: 55,
      //     child: ElevatedButton(
      //       onPressed: () {
      //         // TODO: Navigate to mini game
      //         debugPrint('Play Mini Game pressed');
      //       },
      //       style: ElevatedButton.styleFrom(
      //         backgroundColor: Colors.orangeAccent,
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(16),
      //         ),
      //         elevation: 6,
      //       ),
      //       child: Text(
      //         widget.selectedLanguage == 'Tagalog'
      //             ? 'Maglaro ng Mini Game'
      //             : 'Play Mini Game',
      //         style: const TextStyle(
      //           fontSize: 20,
      //           fontWeight: FontWeight.bold,
      //           color: Colors.white,
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
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
              itemCount: colors.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final item = colors[index];
                final eng = item['eng'] as String;
                final tag = item['tag'] as String;
                final label = widget.selectedLanguage == 'Tagalog' ? tag : eng;
                final bgColor = item['color'] as Color;

                return GestureDetector(
                  onTap: () => _playColorAudio(eng, tag),
                  child: Container(
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: bgColor == Colors.white
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
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
