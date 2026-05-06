import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/star_row.dart';
import '../../data/repositories/albums_repository.dart';
import '../../domain/models/album_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _ctrl = TextEditingController();
  final _focus = FocusNode();
  String _query = '';

  List<Album> get _filtered {
    if (_query.trim().isEmpty) return kAlbums;
    final q = _query.toLowerCase();
    return kAlbums
        .where(
          (a) =>
              a.title.toLowerCase().contains(q) ||
              a.artist.toLowerCase().contains(q) ||
              a.genre.toLowerCase().contains(q) ||
              a.abbr.toLowerCase().contains(q),
        )
        .toList();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    final results = _filtered;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: top + 16),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: BoxDecoration(
            color: C.card,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: C.textSec, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _ctrl,
                  focusNode: _focus,
                  autofocus: false,
                  style: const TextStyle(color: C.textPri, fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: 'Buscar álbuns, artistas...',
                    hintStyle: TextStyle(color: C.textSec, fontSize: 14),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    filled: false,
                  ),
                  onChanged: (v) => setState(() => _query = v),
                ),
              ),
              if (_query.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    _ctrl.clear();
                    setState(() => _query = '');
                  },
                  child: const Icon(Icons.close, color: C.textSec, size: 18),
                ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            _query.isEmpty
                ? 'TODOS OS ÁLBUNS'
                : '${results.length} RESULTADO${results.length != 1 ? 'S' : ''} PARA "${_query.toUpperCase()}"',
            style: const TextStyle(
              color: C.textSec,
              fontSize: 11,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        const SizedBox(height: 12),

        Expanded(
          child:
              results.isEmpty
                  ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.search_off_rounded,
                          color: C.textMut,
                          size: 48,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Nenhum resultado para "$_query"',
                          style: const TextStyle(
                            color: C.textSec,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                  : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 12),
                    itemCount: results.length,
                    itemBuilder: (ctx, i) => _AlbumTile(album: results[i]),
                  ),
        ),
      ],
    );
  }
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
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Color(album.colorValue),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              album.abbr,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 11,
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
                  '${album.artist} · ${album.genre}',
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
