import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

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
    child: Row(
      children: [
        const Icon(Icons.search, color: C.textSec, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            hint,
            style: const TextStyle(color: C.textSec, fontSize: 14),
          ),
        ),
        if (hasX) const Icon(Icons.close, color: C.textSec, size: 18),
        if (!hasX)
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: Colors.black26,
              shape: BoxShape.circle,
            ),
          ),
      ],
    ),
  );
}
