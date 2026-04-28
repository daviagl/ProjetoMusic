import 'package:flutter/material.dart';
import '../core/app_theme.dart'; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _genres = [
    (label: 'Fusion', color: Color(0xFF3D1F5A)),
    (label: 'Rock',   color: Color(0xFF5A3A00)),
    (label: 'Rap',    color: Color(0xFF0A3A3A)),
    (label: 'Funk',   color: Color(0xFF3A0A2A)),
  ];

  @override
  Widget build(BuildContext ctx) {
    final top = MediaQuery.of(ctx).padding.top;
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: top + 16, bottom: 12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const TopSearchBar(hint: 'Digite para buscar músicas...'),
        const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('BOA NOITE', style: TextStyle(color: C.textSec, fontSize: 11, letterSpacing: 1.2, fontWeight: FontWeight.w500)),
            SizedBox(height: 2),
            Text('Explore gêneros', style: TextStyle(color: C.textPri, fontSize: 24, fontWeight: FontWeight.w800, letterSpacing: -.5)),
          ]),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.count(
            crossAxisCount: 2, shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.15,
            children: _genres.map((g) => _GenreCard(label: g.label, color: g.color)).toList(),
          ),
        ),
        const SizedBox(height: 28),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('EM ALTA AGORA', style: TextStyle(color: C.textSec, fontSize: 11, letterSpacing: 1.2, fontWeight: FontWeight.w500)),
        ),
        const SizedBox(height: 12),
        const _TrendingTile(title: 'Loveless', artist: 'My Bloody Valentine', rating: 4.8, color: Color(0xFF3D1020)),
      ]),
    );
  }
}

class _GenreCard extends StatelessWidget {
  final String label; final Color color;
  const _GenreCard({required this.label, required this.color});
  @override
  Widget build(BuildContext ctx) => Container(
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: [
          const Text('GÊNERO', style: TextStyle(color: C.textSec, fontSize: 10, letterSpacing: 1.0, fontWeight: FontWeight.w500)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(color: C.textPri, fontSize: 18, fontWeight: FontWeight.w700)),
        ]),
      );
}

class _TrendingTile extends StatelessWidget {
  final String title, artist; final double rating; final Color color;
  const _TrendingTile({required this.title, required this.artist, required this.rating, required this.color});
  @override
  Widget build(BuildContext ctx) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: C.card, borderRadius: BorderRadius.circular(14)),
        child: Row(children: [
          Container(width: 48, height: 48, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8))),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(color: C.textPri, fontSize: 14, fontWeight: FontWeight.w600)),
            Text(artist, style: const TextStyle(color: C.textSec, fontSize: 12)),
          ])),
          StarRow(rating: rating),
        ]),
      );
}
