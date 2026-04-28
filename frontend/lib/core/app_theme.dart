import 'package:flutter/material.dart';

// CORES
abstract class C {
  static const bg       = Color(0xFF0A0A12);
  static const surface  = Color(0xFF13131F);
  static const card      = Color(0xFF1A1A28);
  static const accent    = Color(0xFF6C63D8);
  static const gold      = Color(0xFFFFB84D);
  static const textPri  = Color(0xFFF2F2F8);
  static const textSec  = Color(0xFF8888A0);
  static const textMut  = Color(0xFF4A4A62);
}

// Search bar compartilhada
class TopSearchBar extends StatelessWidget {
  final String hint;
  final bool hasX;
  const TopSearchBar({super.key, required this.hint, this.hasX = false});

  @override
  Widget build(BuildContext ctx) => Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: C.card,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(children: [
          const Icon(Icons.search, color: C.textSec, size: 18),
          const SizedBox(width: 8),
          Expanded(
              child: Text(hint,
                  style: const TextStyle(color: C.textSec, fontSize: 14))),
          if (hasX)
            const Icon(Icons.close, color: C.textSec, size: 18),
          if (!hasX)
            Container(
              width: 28, height: 28,
              decoration: const BoxDecoration(
                  color: Colors.black26, shape: BoxShape.circle),
            ),
        ]),
      );
}

// Estrelas compartilhadas
class StarRow extends StatelessWidget {
  final double rating;
  const StarRow({super.key, required this.rating});
  @override
  Widget build(BuildContext ctx) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, color: C.gold, size: 12),
          const SizedBox(width: 2),
          Text(rating.toStringAsFixed(1),
              style: const TextStyle(color: C.gold, fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      );
}