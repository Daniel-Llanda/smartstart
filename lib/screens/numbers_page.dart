import 'dart:ui';
import 'package:flutter/material.dart';

class NumbersPage extends StatelessWidget {
  final int ageValue;
  final String selectedLanguage;

  const NumbersPage({
    super.key,
    required this.ageValue,
    required this.selectedLanguage,
  });

  /// 🔢 Number names in Tagalog
  final Map<int, String> tagalogNumbers = const {
    1: 'Isa',
    2: 'Dalawa',
    3: 'Tatlo',
    4: 'Apat',
    5: 'Lima',
    6: 'Anim',
    7: 'Pito',
    8: 'Walo',
    9: 'Siyam',
    10: 'Sampu',
    11: 'Labing-isa',
    12: 'Labindalawa',
    13: 'Labintatlo',
    14: 'Labing-apat',
    15: 'Labinlima',
    16: 'Labing-anim',
    17: 'Labimpito',
    18: 'Labing-walo',
    19: 'Labinsiyam',
    20: 'Dalawampu',
    21: 'Dalawampu’t isa',
    22: 'Dalawampu’t dalawa',
    23: 'Dalawampu’t tatlo',
    24: 'Dalawampu’t apat',
    25: 'Dalawampu’t lima',
    26: 'Dalawampu’t anim',
    27: 'Dalawampu’t pito',
    28: 'Dalawampu’t walo',
    29: 'Dalawampu’t siyam',
    30: 'Tatlongpung',
  };

  /// 🔢 Number names in English
  final Map<int, String> englishNumbers = const {
    1: 'One',
    2: 'Two',
    3: 'Three',
    4: 'Four',
    5: 'Five',
    6: 'Six',
    7: 'Seven',
    8: 'Eight',
    9: 'Nine',
    10: 'Ten',
    11: 'Eleven',
    12: 'Twelve',
    13: 'Thirteen',
    14: 'Fourteen',
    15: 'Fifteen',
    16: 'Sixteen',
    17: 'Seventeen',
    18: 'Eighteen',
    19: 'Nineteen',
    20: 'Twenty',
    21: 'Twenty-one',
    22: 'Twenty-two',
    23: 'Twenty-three',
    24: 'Twenty-four',
    25: 'Twenty-five',
    26: 'Twenty-six',
    27: 'Twenty-seven',
    28: 'Twenty-eight',
    29: 'Twenty-nine',
    30: 'Thirty',
  };

  /// 🔢 Generate numbers based on age
  List<Map<String, dynamic>> getNumbersByAge() {
    int max;

    if (ageValue == 2) {
      max = 10;
    } else if (ageValue == 3) {
      max = 20;
    } else {
      max = 30;
    }

    return List.generate(max, (index) {
      final number = index + 1;
      return {
        'value': number,
        'label': selectedLanguage == 'Tagalog'
            ? tagalogNumbers[number]!
            : englishNumbers[number]!,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    final numbers = getNumbersByAge();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          selectedLanguage == 'Tagalog' ? 'Numero' : 'Numbers',
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

          /// 🔢 Numbers Grid with Images
          Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              itemCount: numbers.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final item = numbers[index];
                final number = item['value'] as int;
                final label = item['label'] as String;

                final imagePath = 'assets/images/numbers/$number.png';

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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        label,
                        style: const TextStyle(
                          fontSize: 22,
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
