import 'package:flutter/material.dart';
import '../core/app_theme.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  static const _albums = [
    (abbr: 'mbv', title: 'My Bloody Valentine', subtitle: 'My Bloody Valentine · 2013', rating: 4.6, color: Color(0xFF3D1020)),
    (abbr: 'LVS', title: 'Loveless', subtitle: 'My Bloody Valentine · 1991', rating: 4.9, color: Color(0xFF3D1020)),
  ];

  @override
  Widget build(BuildContext ctx) {
    final top = MediaQuery.of(ctx).padding.top;
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: top + 16, bottom: 12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const TopSearchBar(hint: 'My Bloody Valentine', hasX: true),
        const SizedBox(height: 24),
        ..._albums.map((a) => _AlbumTile(abbr: a.abbr, title: a.title, subtitle: a.subtitle, rating: a.rating, color: a.color)),
      ]),
    );
  }
}

class _AlbumTile extends StatelessWidget {
  final String abbr, title, subtitle; final double rating; final Color color;
  const _AlbumTile({required this.abbr, required this.title, required this.subtitle, required this.rating, required this.color});
  @override
  Widget build(BuildContext ctx) => Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: C.card, borderRadius: BorderRadius.circular(14)),
        child: Row(children: [
          Container(
            width: 44, height: 44, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            child: Text(abbr, style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(color: C.textPri, fontSize: 14, fontWeight: FontWeight.w600)),
            Text(subtitle, style: const TextStyle(color: C.textSec, fontSize: 12)),
          ])),
          StarRow(rating: rating),
        ]),
      );
}
