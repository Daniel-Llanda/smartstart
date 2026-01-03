import 'dart:ui';
import 'package:flutter/material.dart';

class ColorsPage extends StatelessWidget {
  final int ageValue;
  final String selectedLanguage;

  const ColorsPage({
    super.key,
    required this.ageValue,
    required this.selectedLanguage,
  });

  /// 🎨 Color data per age
  List<Map<String, dynamic>> getColorsByAge() {
    final allColors = [
      {
        'color': Colors.red,
        'eng': 'Red',
        'tag': 'Pula',
      },
      {
        'color': Colors.green,
        'eng': 'Green',
        'tag': 'Berde',
      },
      {
        'color': Colors.blue,
        'eng': 'Blue',
        'tag': 'Asul',
      },
      {
        'color': Colors.yellow,
        'eng': 'Yellow',
        'tag': 'Dilaw',
      },
      {
        'color': Colors.orange,
        'eng': 'Orange',
        'tag': 'Kahel',
      },
      {
        'color': Colors.black,
        'eng': 'Black',
        'tag': 'Itim',
      },
      {
        'color': Colors.purple,
        'eng': 'Purple',
        'tag': 'Lila',
      },
      {
        'color': Colors.pink,
        'eng': 'Pink',
        'tag': 'Rosas',
      },
      {
        'color': Colors.brown,
        'eng': 'Brown',
        'tag': 'Kayumanggi',
      },
      {
        'color': Colors.white,
        'eng': 'White',
        'tag': 'Puti',
      },
      {
        'color': Colors.grey,
        'eng': 'Grey',
        'tag': 'Abo',
      },
      {
        'color': const Color(0xFFFFD700),
        'eng': 'Gold',
        'tag': 'Ginto',
      },
    ];

    if (ageValue == 2) {
      return allColors.take(4).toList();
    } else if (ageValue == 3) {
      return allColors.take(8).toList();
    } else {
      return allColors.take(12).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = getColorsByAge();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          selectedLanguage == 'Tagalog' ? 'Kulay' : 'Colors',
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

          /// 🎨 Color Grid
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: GridView.builder(
              itemCount: colors.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final item = colors[index];
                final label = selectedLanguage == 'Tagalog'
                    ? item['tag']
                    : item['eng'];

                return Container(
                  decoration: BoxDecoration(
                    color: item['color'],
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
                        color: item['color'] == Colors.white
                            ? Colors.black
                            : Colors.white,
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
