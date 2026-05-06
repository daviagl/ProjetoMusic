import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/app_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const _favAlbums = [
    (label: 'IV', color: Color(0xFF3A1A00)),
    (label: 'MOP', color: Color(0xFF2A0A0A)),
    (label: 'NVM', color: Color(0xFF0A1A3A)),
    (label: 'DSM', color: Color(0xFF0A0A2A)),
  ];

  static const _reviews = [
    (
      title: 'Back in Black',
      artist: 'AC/DC',
      rating: 5.0,
      time: '1d atrás',
      color: Color(0xFF1A1A1A),
    ),
    (
      title: 'Master of Puppets',
      artist: 'Metallica',
      rating: 4.5,
      time: '3d atrás',
      color: Color(0xFF2A0A0A),
    ),
    (
      title: 'Nevermind',
      artist: 'Nirvana',
      rating: 4.0,
      time: '1sem atrás',
      color: Color(0xFF0A1A3A),
    ),
    (
      title: 'Led Zeppelin IV',
      artist: 'Led Zeppelin',
      rating: 5.0,
      time: '2sem atrás',
      color: Color(0xFF3A1A00),
    ),
  ];

  @override
  Widget build(BuildContext ctx) {
    final top = MediaQuery.of(ctx).padding.top;
    final usuario = Auth.instance.usuarioAtual;
    final nomeDisplay = usuario?.nome ?? 'Usuário';
    final inicial = nomeDisplay.isNotEmpty ? nomeDisplay[0].toUpperCase() : 'U';

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: top + 16, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'MEU PERFIL',
                  style: TextStyle(
                    color: C.textSec,
                    fontSize: 11,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final confirmar = await showDialog<bool>(
                      context: ctx,
                      builder:
                          (dialogCtx) => AlertDialog(
                            backgroundColor: C.surface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            title: const Text(
                              'Sair da conta',
                              style: TextStyle(
                                color: C.textPri,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            content: const Text(
                              'Tem certeza que deseja sair?',
                              style: TextStyle(color: C.textSec, fontSize: 14),
                            ),
                            actions: [
                              TextButton(
                                onPressed:
                                    () => Navigator.of(dialogCtx).pop(false),
                                child: const Text(
                                  'Cancelar',
                                  style: TextStyle(color: C.textSec),
                                ),
                              ),
                              TextButton(
                                onPressed:
                                    () => Navigator.of(dialogCtx).pop(true),
                                child: const Text(
                                  'Sair',
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                    );
                    if (confirmar == true) {
                      Auth.instance.logout();
                      ctx.go('/login');
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: C.card,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: C.textMut.withValues(alpha: 0.4),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.logout_rounded, color: C.textSec, size: 12),
                        SizedBox(width: 5),
                        Text(
                          'Sair',
                          style: TextStyle(
                            color: C.textSec,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: C.accent, width: 2.5),
                  ),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: C.accent.withValues(alpha: 0.15),
                    child: Text(
                      inicial,
                      style: const TextStyle(
                        color: C.accent,
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  nomeDisplay,
                  style: const TextStyle(
                    color: C.textPri,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: C.card,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _Stat(value: '142', label: 'reviews'),
                      _StatDivider(),
                      _Stat(value: '38', label: 'favoritos'),
                      _StatDivider(),
                      _Stat(value: '210', label: 'ouvidas'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const _SectionHeader(label: 'ÁLBUNS FAVORITOS'),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children:
                  _favAlbums
                      .map(
                        (a) => Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            height: 72,
                            decoration: BoxDecoration(
                              color: a.color,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.music_note_rounded,
                                  color: Colors.white24,
                                  size: 18,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  a.label,
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const _SectionHeader(label: 'REVIEWS RECENTES'),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(
                  'Ver todos',
                  style: TextStyle(
                    color: C.accent,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ..._reviews.map(
            (r) => _ReviewTile(
              title: r.title,
              artist: r.artist,
              rating: r.rating,
              time: r.time,
              color: r.color,
            ),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String value, label;
  const _Stat({required this.value, required this.label});
  @override
  Widget build(BuildContext ctx) => Column(
    children: [
      Text(
        value,
        style: const TextStyle(
          color: C.textPri,
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(height: 2),
      Text(label, style: const TextStyle(color: C.textSec, fontSize: 11)),
    ],
  );
}

class _StatDivider extends StatelessWidget {
  const _StatDivider();
  @override
  Widget build(BuildContext ctx) =>
      Container(width: 1, height: 32, color: C.textMut.withValues(alpha: 0.4));
}

class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});
  @override
  Widget build(BuildContext ctx) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        Container(
          width: 3,
          height: 14,
          color: C.accent,
          margin: const EdgeInsets.only(right: 8),
        ),
        Text(
          label,
          style: const TextStyle(
            color: C.textSec,
            fontSize: 11,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

class _ReviewTile extends StatelessWidget {
  final String title, artist, time;
  final double rating;
  final Color color;
  const _ReviewTile({
    required this.title,
    required this.artist,
    required this.rating,
    required this.time,
    required this.color,
  });

  @override
  Widget build(BuildContext ctx) => Container(
    margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: C.card,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.music_note_rounded,
            color: Colors.white30,
            size: 18,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: C.textPri,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                artist,
                style: const TextStyle(color: C.textSec, fontSize: 12),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                5,
                (i) => Icon(
                  i < rating.floor()
                      ? Icons.music_note_rounded
                      : (i < rating && rating % 1 >= 0.5)
                      ? Icons.music_note_rounded
                      : Icons.music_note_outlined,
                  color:
                      i < rating.floor() || (i < rating && rating % 1 >= 0.5)
                          ? (i < rating.floor()
                              ? C.gold
                              : C.gold.withValues(alpha: 0.45))
                          : C.gold,
                  size: 13,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(time, style: const TextStyle(color: C.textMut, fontSize: 10)),
          ],
        ),
      ],
    ),
  );
}
