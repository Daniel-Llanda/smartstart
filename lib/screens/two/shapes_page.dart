import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ShapesPage extends StatelessWidget {
  final String language;

  const ShapesPage({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    final FlutterTts flutterTts = FlutterTts();

    final items = [
      {
        'label': language == 'Tagalog' ? 'Bilog' : 'Circle',
        'shape': const CircleAvatar(radius: 40, backgroundColor: Colors.red),
      },
      {
        'label': language == 'Tagalog' ? 'Parisukat' : 'Square',
        'shape': Container(width: 80, height: 80, color: Colors.green),
      },
      {
        'label': language == 'Tagalog' ? 'Tatsulok' : 'Triangle',
        'shape': CustomPaint(
          size: const Size(80, 80),
          painter: TrianglePainter(),
        ),
      },
      {
        'label': language == 'Tagalog' ? 'Parihaba' : 'Rectangle',
        'shape': Container(width: 100, height: 60, color: Colors.blue),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(language == 'Tagalog' ? 'Mga Hugis' : 'Shapes'),
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
              final shapeWidget = item['shape'] as Widget;

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
                    shapeWidget,
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

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.orange;
    final path =
        Path()
          ..moveTo(size.width / 2, 0)
          ..lineTo(0, size.height)
          ..lineTo(size.width, size.height)
          ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
