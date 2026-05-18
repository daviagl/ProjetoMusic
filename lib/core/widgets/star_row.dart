import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class StarRow extends StatelessWidget {
  final double rating;
  const StarRow({super.key, required this.rating});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Icon(Icons.music_note_rounded, color: C.gold, size: 12),
      const SizedBox(width: 2),
      Text(
        rating.toStringAsFixed(1),
        style: const TextStyle(
          color: C.gold,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}
