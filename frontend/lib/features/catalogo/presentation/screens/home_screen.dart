import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/star_row.dart';
import '../../data/repositories/albums_repository.dart';
import '../../domain/models/album_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedGenre;

  static const _genres = [
    (label: 'Rock', icon: Icons.queue_music_rounded, color: Color(0xFF3A2200)),
    (label: 'Metal', icon: Icons.bolt_rounded, color: Color(0xFF2A0A0A)),
    (label: 'Grunge', icon: Icons.music_note_rounded, color: Color(0xFF0A1A2A)),
    (
      label: 'Classic Rock',
      icon: Icons.album_rounded,
      color: Color(0xFF2D1A50),
    ),
    (label: 'Punk', icon: Icons.flash_on_rounded, color: Color(0xFF3A1800)),
    (
      label: 'Alt Rock',
      icon: Icons.library_music_rounded,
      color: Color(0xFF0A2A1A),
    ),
  ];

  List<Album> get _trending {
    if (_selectedGenre == null) return kAlbums.take(5).toList();
    return kAlbums.where((a) => a.genre == _selectedGenre).toList();
  }

  void _toggleGenre(String genre) {
    setState(() => _selectedGenre = _selectedGenre == genre ? null : genre);
  }

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'BOM DIA';
    if (h < 18) return 'BOA TARDE';
    return 'BOA NOITE';
  }

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    final screenW = MediaQuery.of(context).size.width;
    final crossCount =
        screenW < 600
            ? 2
            : screenW < 1000
            ? 3
            : 4;
    final aspectRatio =
        screenW < 600
            ? 1.15
            : screenW < 1000
            ? 1.3
            : 1.5;
    final trending = _trending;

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: top + 16, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _greeting(),
                  style: const TextStyle(
                    color: C.textSec,
                    fontSize: 11,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Explore gêneros',
                  style: TextStyle(
                    color: C.textPri,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              crossAxisCount: crossCount,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: aspectRatio,
              children:
                  _genres
                      .map(
                        (g) => _GenreCard(
                          label: g.label,
                          icon: g.icon,
                          color: g.color,
                          selected: _selectedGenre == g.label,
                          onTap: () => _toggleGenre(g.label),
                        ),
                      )
                      .toList(),
            ),
          ),

          const SizedBox(height: 28),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedGenre != null
                      ? _selectedGenre!.toUpperCase()
                      : 'EM ALTA AGORA',
                  style: const TextStyle(
                    color: C.textSec,
                    fontSize: 11,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (_selectedGenre != null)
                  GestureDetector(
                    onTap: () => setState(() => _selectedGenre = null),
                    child: const Text(
                      'Limpar filtro',
                      style: TextStyle(
                        color: C.accent,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          if (trending.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Center(
                child: Text(
                  'Nenhum álbum neste gênero ainda.',
                  style: TextStyle(color: C.textSec, fontSize: 13),
                ),
              ),
            )
          else if (screenW >= 600)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                crossAxisCount: screenW < 1000 ? 2 : 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 3.5,
                children: trending.map((a) => _AlbumTile(album: a)).toList(),
              ),
            )
          else
            Column(
              children: trending.map((a) => _AlbumTile(album: a)).toList(),
            ),
        ],
      ),
    );
  }
}

class _GenreCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const _GenreCard({
    required this.label,
    required this.icon,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border:
            selected
                ? Border.all(color: C.accent, width: 2)
                : Border.all(color: Colors.transparent, width: 2),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: C.textPri.withValues(alpha: 0.8),
              size: 17,
            ),
          ),
          const Spacer(),
          const Text(
            'GÊNERO',
            style: TextStyle(
              color: C.textSec,
              fontSize: 10,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              color: C.textPri,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    ),
  );
}

class _AlbumTile extends StatelessWidget {
  final Album album;
  const _AlbumTile({required this.album});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => context.push('/album/${album.id}'),
    child: Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: C.card,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Color(album.colorValue),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              album.abbr,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  album.title,
                  style: const TextStyle(
                    color: C.textPri,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  album.artist,
                  style: const TextStyle(color: C.textSec, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          StarRow(rating: album.rating),
          const SizedBox(width: 6),
          const Icon(Icons.chevron_right_rounded, color: C.textMut, size: 18),
        ],
      ),
    ),
  );
}
