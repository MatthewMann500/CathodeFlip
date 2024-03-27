import 'package:flutter/material.dart';

class LevelDisplay extends StatelessWidget {
  final int level;
  final int points;
  const LevelDisplay({super.key, required this.level, required this.points});

  @override
  Widget build(BuildContext context) {
    print(points);
    String formattedNumber = points.toString().padLeft(5, '0');
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Level: $level',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Points: $formattedNumber', // Placeholder text
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}