import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math' as math;

class ShapesPage extends StatelessWidget {
  final String language;

  const ShapesPage({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    final FlutterTts flutterTts = FlutterTts();
    final isTagalog = language == 'Tagalog';

    final items = [
      {
        'label': isTagalog ? 'Bilog' : 'Circle',
        'shape': const CircleAvatar(radius: 40, backgroundColor: Colors.red),
      },
      {
        'label': isTagalog ? 'Parisukat' : 'Square',
        'shape': Container(width: 80, height: 80, color: Colors.green),
      },
      {
        'label': isTagalog ? 'Tatsulok' : 'Triangle',
        'shape': CustomPaint(
          size: const Size(80, 80),
          painter: TrianglePainter(),
        ),
      },
      {
        'label': isTagalog ? 'Parihaba' : 'Rectangle',
        'shape': Container(width: 100, height: 60, color: Colors.blue),
      },
      {
        'label': isTagalog ? 'Obalo' : 'Oval',
        'shape': Container(
          width: 100,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(60),
          ),
        ),
      },
      {
        'label': isTagalog ? 'Bituin' : 'Star',
        'shape': CustomPaint(size: const Size(80, 80), painter: StarPainter()),
      },
      {
        'label': isTagalog ? 'Diamante' : 'Diamond',
        'shape': CustomPaint(
          size: const Size(80, 80),
          painter: DiamondPainter(),
        ),
      },
      {
        'label': isTagalog ? 'Puso' : 'Heart',
        'shape': CustomPaint(size: const Size(80, 80), painter: HeartPainter()),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(isTagalog ? 'Mga Hugis' : 'Shapes'),
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
                  await flutterTts.setLanguage(isTagalog ? 'tl-PH' : 'en-US');
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

// Triangle Painter
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

// Star Painter
class StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.yellow;
    final path = Path();

    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width / 2;
    final rInner = r * 0.5;

    for (int i = 0; i < 10; i++) {
      final angle = math.pi / 5 * i;
      final radius = i.isEven ? r : rInner;
      final x = cx + radius * math.cos(angle - math.pi / 2);
      final y = cy + radius * math.sin(angle - math.pi / 2);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Diamond Painter
class DiamondPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.purple;
    final path =
        Path()
          ..moveTo(size.width / 2, 0)
          ..lineTo(size.width, size.height / 2)
          ..lineTo(size.width / 2, size.height)
          ..lineTo(0, size.height / 2)
          ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Heart Painter
class HeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.pink;
    final path =
        Path()
          ..moveTo(size.width / 2, size.height * 0.75)
          ..cubicTo(
            -10,
            size.height * 0.3,
            size.width * 0.25,
            0,
            size.width / 2,
            size.height * 0.25,
          )
          ..cubicTo(
            size.width * 0.75,
            0,
            size.width + 10,
            size.height * 0.3,
            size.width / 2,
            size.height * 0.75,
          )
          ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
