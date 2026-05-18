import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/models/album_model.dart';
import '../../domain/models/review_model.dart';

final Map<String, List<Review>> _kReviews = {
  'led-iv': [
    const Review(
      user: 'MetaleiroBR320',
      stars: 5,
      text:
          'Stairway to Heaven é uma das músicas mais perfeitas já gravadas. O álbum inteiro é uma obra de arte.',
      date: '2d atrás',
    ),
    const Review(
      user: 'Cabeça-de-Album240',
      stars: 5,
      text:
          'Cada faixa é um universo. Led Zeppelin IV redefiniu o rock para sempre.',
      date: '1sem atrás',
    ),
  ],
  'master-of-puppets': [
    const Review(
      user: 'CharlieBrown1990',
      stars: 5,
      text:
          'O thrash metal em sua forma mais pura. Battery + Master of Puppets = perfeição.',
      date: '3d atrás',
    ),
  ],
  'back-in-black': [
    const Review(
      user: 'RoqueiroBaiano',
      stars: 5,
      text:
          'O riff de Back in Black é um dos mais icônicos da história do rock. O álbum é um marco para a banda.',
      date: '5d atrás',
    ),
  ],
  'the-dark-side-of-the-moon': [
    const Review(
      user: 'ApreciadorDeRock2000',
      stars: 5,
      text:
          'Uma jornada sonora incrível. The Dark Side of the Moon é um dos álbuns mais impactantes da história do rock.',
      date: '1m atrás',
    ),
  ],
  'abbey-road': [
    const Review(
      user: 'Irmao_do_PaulMcCartney',
      stars: 5,
      text:
          'Um dos álbuns mais influentes da história do rock. A capa é uma obra de arte.',
      date: '2m atrás',
    ),
  ],
  'rumours': [
    const Review(
      user: 'fleetwood_fanNumeroUm',
      stars: 5,
      text:
          'As canções de Rumours são tão pessoais e emocionantes. Um álbum que resiste ao tempo.',
      date: '3m atrás',
    ),
  ],
  'hotel-california': [
    const Review(
      user: 'EagleEye',
      stars: 5,
      text:
          'Hotel California é um clássico atemporal. A faixa-título é uma das melhores da história do rock.',
      date: '4m atrás',
    ),
  ],
};

List<Review> _getReviews(String albumId) =>
    List.unmodifiable(_kReviews[albumId] ?? []);

Review? _getMyReview(String albumId) {
  try {
    return (_kReviews[albumId] ?? []).firstWhere((r) => r.isMine);
  } catch (_) {
    return null;
  }
}

bool _hasMyReview(String albumId) => _getMyReview(albumId) != null;

void _addOrUpdateMyReview(String albumId, Review review) {
  final list = List<Review>.from(_kReviews[albumId] ?? []);
  final idx = list.indexWhere((r) => r.isMine);
  if (idx >= 0) {
    list[idx] = review;
  } else {
    list.insert(0, review);
  }
  _kReviews[albumId] = list;
}

class AlbumDetailScreen extends StatefulWidget {
  final Album album;
  const AlbumDetailScreen({super.key, required this.album});

  @override
  State<AlbumDetailScreen> createState() => _AlbumDetailScreenState();
}

class _AlbumDetailScreenState extends State<AlbumDetailScreen> {
  bool _isFavorited = false;

  List<Review> get _reviews => _getReviews(widget.album.id);
  bool get _myReviewExists => _hasMyReview(widget.album.id);
  Review? get _myReview => _getMyReview(widget.album.id);

  void _toggleFavorite() => setState(() => _isFavorited = !_isFavorited);

  void _openReviewModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (_) => _ReviewModal(
            album: widget.album,
            existingReview: _myReview,
            onSubmit: (review) {
              _addOrUpdateMyReview(widget.album.id, review);
              setState(() {});
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    final reviews = _reviews;

    return Scaffold(
      backgroundColor: C.bg,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: top),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: C.textSec,
                      size: 18,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  IconButton(
                    icon: Icon(
                      _isFavorited
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: _isFavorited ? const Color(0xFFE05070) : C.textSec,
                      size: 22,
                    ),
                    onPressed: _toggleFavorite,
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: Color(widget.album.colorValue),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Color(
                        widget.album.colorValue,
                      ).withValues(alpha: 0.5),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  widget.album.abbr,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.album.title,
                    style: const TextStyle(
                      color: C.textPri,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${widget.album.artist.toUpperCase()}  ·  ${widget.album.year}',
                    style: const TextStyle(
                      color: C.textSec,
                      fontSize: 12,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _StarRowFull(rating: widget.album.rating, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        widget.album.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          color: C.gold,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '· ${widget.album.ratingCount} avaliações',
                        style: const TextStyle(color: C.textSec, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _myReviewExists ? C.card : C.accent,
                    foregroundColor: _myReviewExists ? C.accent : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side:
                          _myReviewExists
                              ? const BorderSide(color: C.accent, width: 1)
                              : BorderSide.none,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  label: Text(
                    _myReviewExists ? 'EDITAR MEU REVIEW' : 'ADICIONAR REVIEW',
                  ),
                  onPressed: _openReviewModal,
                ),
              ),
            ),
            const SizedBox(height: 28),
            const _SectionHeader(label: 'SOBRE O ÁLBUM'),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.album.about,
                style: const TextStyle(
                  color: C.textSec,
                  fontSize: 13,
                  height: 1.65,
                ),
              ),
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const _SectionHeader(label: 'REVIEWS'),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    '${reviews.length} avaliações',
                    style: const TextStyle(color: C.textMut, fontSize: 11),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (reviews.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.rate_review_outlined,
                        color: C.textMut,
                        size: 40,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Seja o primeiro a avaliar!',
                        style: TextStyle(color: C.textSec, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              )
            else
              ...reviews.map((r) => _ReviewCard(review: r)),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _ReviewModal extends StatefulWidget {
  final Album album;
  final Review? existingReview;
  final void Function(Review) onSubmit;

  const _ReviewModal({
    required this.album,
    required this.onSubmit,
    this.existingReview,
  });

  @override
  State<_ReviewModal> createState() => _ReviewModalState();
}

class _ReviewModalState extends State<_ReviewModal> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  int _selectedStars = 0;
  bool _isSubmitting = false;

  static const _starLabels = ['', 'Horrível', 'Ruim', 'Ok', 'Bom', 'Excelente'];

  @override
  void initState() {
    super.initState();
    if (widget.existingReview != null) {
      _selectedStars = widget.existingReview!.stars.toInt();
      _textController.text = widget.existingReview!.text;
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_selectedStars == 0) return;
    setState(() => _isSubmitting = true);

    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;

    final review = Review(
      user: 'você',
      stars: _selectedStars.toDouble(),
      text:
          _textController.text.trim().isEmpty
              ? 'Sem comentário.'
              : _textController.text.trim(),
      date: 'agora',
      isMine: true,
    );

    widget.onSubmit(review);
    setState(() => _isSubmitting = false);
    if (!mounted) return;
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.white,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              widget.existingReview != null
                  ? 'Review atualizado!'
                  : 'Review publicado!',
            ),
          ],
        ),
        backgroundColor: const Color(0xFF2A5A2A),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF13131F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(20, 12, 20, 20 + bottomInset),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: C.textMut,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Text(
            widget.existingReview != null
                ? 'Editar Review'
                : 'Adicionar Review',
            style: const TextStyle(
              color: C.textPri,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${widget.album.title} · ${widget.album.artist}',
            style: const TextStyle(color: C.textSec, fontSize: 12),
          ),
          const SizedBox(height: 20),
          const Text(
            'SUA AVALIAÇÃO',
            style: TextStyle(
              color: C.textSec,
              fontSize: 10,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (i) {
              final filled = i < _selectedStars;
              return GestureDetector(
                onTap: () => setState(() => _selectedStars = i + 1),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                  child: Icon(
                    filled
                        ? Icons.music_note_rounded
                        : Icons.music_note_outlined,
                    color: filled ? C.gold : C.textMut,
                    size: filled ? 36 : 32,
                  ),
                ),
              );
            }),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child:
                _selectedStars > 0
                    ? Padding(
                      key: ValueKey(_selectedStars),
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        _starLabels[_selectedStars],
                        style: const TextStyle(
                          color: C.gold,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                    : const SizedBox(key: ValueKey(0), height: 22),
          ),
          const SizedBox(height: 16),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'SEU REVIEW (OPCIONAL)',
              style: TextStyle(
                color: C.textSec,
                fontSize: 10,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _textController,
            focusNode: _focusNode,
            maxLines: 4,
            style: const TextStyle(color: C.textPri, fontSize: 13),
            decoration: InputDecoration(
              hintText: 'O que você achou deste álbum?',
              hintStyle: const TextStyle(color: C.textMut, fontSize: 13),
              filled: true,
              fillColor: C.card,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: C.card),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: C.accent, width: 1.5),
              ),
              contentPadding: const EdgeInsets.all(14),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: C.textSec,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: C.card),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedStars > 0 ? C.accent : C.card,
                    foregroundColor:
                        _selectedStars > 0 ? Colors.white : C.textMut,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed:
                      (_selectedStars > 0 && !_isSubmitting) ? _submit : null,
                  child:
                      _isSubmitting
                          ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                          : const Text('PUBLICAR'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
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

class _StarRowFull extends StatelessWidget {
  final double rating;
  final double size;
  const _StarRowFull({required this.rating, this.size = 14});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(5, (i) {
      if (i < rating.floor()) {
        return Icon(Icons.music_note_rounded, color: C.gold, size: size);
      } else if (i < rating && rating % 1 >= 0.5) {
        return Icon(
          Icons.music_note_rounded,
          color: C.gold.withValues(alpha: 0.45),
          size: size,
        );
      } else {
        return Icon(Icons.music_note_outlined, color: C.textMut, size: size);
      }
    }),
  );
}

class _ReviewCard extends StatelessWidget {
  final Review review;
  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: C.card,
      borderRadius: BorderRadius.circular(14),
      border:
          review.isMine
              ? Border.all(color: C.accent.withValues(alpha: 0.5), width: 1)
              : null,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 13,
                  backgroundColor: C.surface,
                  child: const Icon(
                    Icons.person_outline_rounded,
                    color: C.textSec,
                    size: 14,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  review.user,
                  style: const TextStyle(
                    color: C.textPri,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (review.isMine) ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: C.accent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: C.accent.withValues(alpha: 0.4),
                      ),
                    ),
                    child: const Text(
                      'meu',
                      style: TextStyle(
                        color: C.accent,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                5,
                (i) => Icon(
                  i < review.stars
                      ? Icons.music_note_rounded
                      : Icons.music_note_outlined,
                  color: C.gold,
                  size: 13,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          review.text,
          style: const TextStyle(color: C.textSec, fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 6),
        Text(
          review.date,
          style: const TextStyle(color: C.textMut, fontSize: 11),
        ),
      ],
    ),
  );
}
