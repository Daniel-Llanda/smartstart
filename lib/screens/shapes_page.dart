import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class ShapesPage extends StatefulWidget {
  final int ageValue;
  final String selectedLanguage;

  const ShapesPage({
    super.key,
    required this.ageValue,
    required this.selectedLanguage,
  });

  @override
  State<ShapesPage> createState() => _ShapesPageState();
}

class _ShapesPageState extends State<ShapesPage> {
  final AudioPlayer _player = AudioPlayer();

  /// 🔤 Shapes in Tagalog
  final Map<String, String> tagalogShapes = const {
    'Circle': 'Bilog',
    'Square': 'Parisukat',
    'Triangle': 'Tatsulok',
    'Rectangle': 'Parihaba',
    'Oval': 'Oblong',
    'Star': 'Bituin',
    'Diamond': 'Diamante',
    'Heart': 'Puso',
    'Pentagon': 'Pentagon',
    'Hexagon': 'Hexagon',
    'Octagon': 'Octagon',
    'Arrow': 'Palaso',
  };

  /// 🔤 Shapes in English
  final Map<String, String> englishShapes = const {
    'Circle': 'Circle',
    'Square': 'Square',
    'Triangle': 'Triangle',
    'Rectangle': 'Rectangle',
    'Oval': 'Oval',
    'Star': 'Star',
    'Diamond': 'Diamond',
    'Heart': 'Heart',
    'Pentagon': 'Pentagon',
    'Hexagon': 'Hexagon',
    'Octagon': 'Octagon',
    'Arrow': 'Arrow',
  };

  /// 🔢 Shapes based on age
  List<String> getShapesByAge() {
    switch (widget.ageValue) {
      case 2:
        return ['Circle', 'Square', 'Triangle', 'Rectangle'];
      case 3:
        return ['Circle', 'Square', 'Triangle', 'Rectangle', 'Oval', 'Star', 'Diamond', 'Heart'];
      case 4:
        return [
          'Circle', 'Square', 'Triangle', 'Rectangle', 'Oval', 'Star',
          'Diamond', 'Heart', 'Pentagon', 'Hexagon', 'Octagon', 'Arrow'
        ];
      default:
        return [];
    }
  }

  /// 🔊 Normalize label → filename
  String _normalizeForAudio(String text) {
    return text.toLowerCase().replaceAll(' ', '-');
  }

  /// 🔊 Play shape audio
  Future<void> _playShapeAudio(String shape) async {
    try {
      final folder = widget.selectedLanguage == 'Tagalog'
          ? 'sounds/shapes/tag/'
          : 'sounds/shapes/eng/';
      final fileName = '${_normalizeForAudio(shape)}.m4a';

      await _player.stop();
      await _player.play(AssetSource('$folder$fileName'));
    } catch (e) {
      debugPrint('Audio error: $e');
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shapes = getShapesByAge();
    final isTagalog = widget.selectedLanguage == 'Tagalog';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white, // ← back button color
        ),
        title: Text(
          isTagalog ? 'Hugis' : 'Shapes',
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
              itemCount: shapes.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final shape = shapes[index];
                final label = isTagalog
                    ? tagalogShapes[shape]!
                    : englishShapes[shape]!;

                return GestureDetector(
                  onTap: () => _playShapeAudio(shape),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
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
                                'assets/images/shapes/${shape.toLowerCase()}.png',
                                fit: BoxFit.contain,
                                color: Colors.white,
                                colorBlendMode: BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),

                        Text(
                          label,
                          style: const TextStyle(
                            fontSize: 22,
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
