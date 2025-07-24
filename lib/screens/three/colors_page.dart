import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ColorsPage extends StatefulWidget {
  final String language;

  const ColorsPage({super.key, required this.language});

  @override
  State<ColorsPage> createState() => _ColorsPageState();
}

class _ColorsPageState extends State<ColorsPage> {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage(
      widget.language == 'Tagalog' ? 'tl-PH' : 'en-US',
    );
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  List<Map<String, dynamic>> getColorItems() {
    final isTagalog = widget.language == 'Tagalog';

    return [
      {'label': isTagalog ? 'Pula' : 'Red', 'color': Colors.red},
      {'label': isTagalog ? 'Berde' : 'Green', 'color': Colors.green},
      {'label': isTagalog ? 'Asul' : 'Blue', 'color': Colors.blue},
      {'label': isTagalog ? 'Dilaw' : 'Yellow', 'color': Colors.yellow},
      {'label': isTagalog ? 'Kahel' : 'Orange', 'color': Colors.orange},
      {'label': isTagalog ? 'Itim' : 'Black', 'color': Colors.black},
      {'label': isTagalog ? 'Lila' : 'Purple', 'color': Colors.purple},
      {'label': isTagalog ? 'Rosas' : 'Pink', 'color': Colors.pink},
    ];
  }

  @override
  Widget build(BuildContext context) {
    final items = getColorItems();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.language == 'Tagalog' ? 'Mga Kulay' : 'Colors'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children:
              items.map((item) {
                return GestureDetector(
                  onTap: () => _speak(item['label']),
                  child: Container(
                    decoration: BoxDecoration(
                      color: item['color'],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        item['label'],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
