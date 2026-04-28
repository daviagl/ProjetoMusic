import 'package:flutter/material.dart';
import '../core/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const _favColors = [
    Color(0xFF5A3A00), Color(0xFF3D1020), Color(0xFF1A1A40), Color(0xFF0A3A3A),
  ];

  static const _reviews = [
    (title: 'Filosofem',           artist: 'Burzum',              rating: 5.0, time: '2d atrás',   color: Color(0xFF3A2A00)),
    (title: 'Loveless',            artist: 'My Bloody Valentine', rating: 3.0, time: '5d atrás',   color: Color(0xFF3D1020)),
    (title: 'Dummy',               artist: 'Portishead',          rating: 4.0, time: '1sem atrás', color: Color(0xFF0A2A3A)),
  ];

  @override
  Widget build(BuildContext ctx) {
    final top = MediaQuery.of(ctx).padding.top;
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: top + 16, bottom: 12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const TopSearchBar(hint: 'Digite para buscar músicas...'),
        const SizedBox(height: 28),
        Center(child: Column(children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: C.accent.withOpacity(0.25),
            child: const Text('U', style: TextStyle(color: C.accent, fontSize: 28, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(height: 10),
          const Text('username', style: TextStyle(color: C.textPri, fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _Stat(value: '142', label: 'reviews'),
            _Divider(),
            _Stat(value: '38', label: 'favoritos'),
            _Divider(),
            _Stat(value: '210', label: 'ouvidas'),
          ]),
        ])),
        const SizedBox(height: 28),
        const _SectionHeader(label: 'ÁLBUNS FAVORITOS'),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(children: _favColors.map((c) => Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              height: 56,
              decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(10)),
            ),
          )).toList()),
        ),
        const SizedBox(height: 28),
        const _SectionHeader(label: 'REVIEWS RECENTES'),
        const SizedBox(height: 12),
        ..._reviews.map((r) => _ReviewTile(title: r.title, artist: r.artist, rating: r.rating, time: r.time, color: r.color)),
      ]),
    );
  }
}

// Widgets de suporte privados (só usados aqui)
class _Stat extends StatelessWidget {
  final String value, label;
  const _Stat({required this.value, required this.label});
  @override
  Widget build(BuildContext ctx) => Column(children: [
    Text(value, style: const TextStyle(color: C.textPri, fontSize: 16, fontWeight: FontWeight.w700)),
    Text(label, style: const TextStyle(color: C.textSec, fontSize: 11)),
  ]);
}

class _Divider extends StatelessWidget {
  const _Divider();
  @override
  Widget build(BuildContext ctx) => Container(width: 1, height: 28, color: C.textMut, margin: const EdgeInsets.symmetric(horizontal: 18));
}

class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});
  @override
  Widget build(BuildContext ctx) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(children: [
      Container(width: 3, height: 14, color: C.accent, margin: const EdgeInsets.only(right: 8)),
      Text(label, style: const TextStyle(color: C.textSec, fontSize: 11, letterSpacing: 1.2, fontWeight: FontWeight.w600)),
    ]),
  );
}

class _ReviewTile extends StatelessWidget {
  final String title, artist, time; final double rating; final Color color;
  const _ReviewTile({required this.title, required this.artist, required this.rating, required this.time, required this.color});
  @override
  Widget build(BuildContext ctx) => Container(
    margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: C.card, borderRadius: BorderRadius.circular(14)),
    child: Row(children: [
      Container(width: 44, height: 44, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8))),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(color: C.textPri, fontSize: 14, fontWeight: FontWeight.w600)),
        Text(artist, style: const TextStyle(color: C.textSec, fontSize: 12)),
      ])),
      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Row(children: List.generate(5, (i) => Icon(
          i < rating.floor() ? Icons.star_rounded : (i < rating && rating % 1 >= 0.5) ? Icons.star_half_rounded : Icons.star_outline_rounded,
          color: C.gold, size: 12))),
        const SizedBox(height: 4),
        Text(time, style: const TextStyle(color: C.textMut, fontSize: 10)),
      ]),
    ]),
  );
}