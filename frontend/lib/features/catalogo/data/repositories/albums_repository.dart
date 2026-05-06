import '../../domain/models/album_model.dart';
import '../../domain/models/review_model.dart';

final List<Album> kAlbums = [
  const Album(
    id: 'the-dark-side-of-the-moon',
    abbr: 'DSOTM',
    title: 'The Dark Side of the Moon',
    artist: 'Pink Floyd',
    year: 1973,
    rating: 4.9,
    ratingCount: '10.5k',
    genre: 'Progressive Rock',
    about:
        'O oitavo álbum de estúdio da banda britânica Pink Floyd, lançado em 1973. Conhecido por sua produção inovadora e temas filosóficos, é um dos álbuns mais vendidos e aclamados de todos os tempos.',
    colorValue: 0xFF000000,
  ),
  const Album(
    id: 'abbey-road',
    abbr: 'AR',
    title: 'Abbey Road',
    artist: 'The Beatles',
    year: 1969,
    rating: 4.8,
    ratingCount: '9.8k',
    genre: 'Rock',
    about:
        'O décimo primeiro álbum de estúdio da banda britânica The Beatles, lançado em 1969. Conhecido por sua icônica capa e por faixas como "Come Together" e "Here Comes the Sun".',
    colorValue: 0xFF1A2A3A,
  ),
  const Album(
    id: 'rumours',
    abbr: 'RUM',
    title: 'Rumours',
    artist: 'Fleetwood Mac',
    year: 1977,
    rating: 4.8,
    ratingCount: '10.2k',
    genre: 'Rock',
    about:
        'O décimo primeiro álbum de estúdio da banda britânica-americana Fleetwood Mac, lançado em 1977. Conhecido por suas canções sobre relacionamentos turbulentos e por ser um dos álbuns mais vendidos de todos os tempos.',
    colorValue: 0xFF3A2A1A,
  ),
  const Album(
    id: 'hotel-california',
    abbr: 'HC',
    title: 'Hotel California',
    artist: 'Eagles',
    year: 1976,
    rating: 4.8,
    ratingCount: '9.6k',
    genre: 'Rock',
    about:
        'O quinto álbum de estúdio da banda americana Eagles, lançado em 1976. Conhecido por sua faixa-título e por ser um dos álbuns mais vendidos de todos os tempos.',
    colorValue: 0xFF2A3A1A,
  ),
];

Album? findAlbumById(String id) {
  try {
    return kAlbums.firstWhere((a) => a.id == id);
  } catch (_) {
    return null;
  }
}

class ReviewRepository {
  ReviewRepository._();
  static final ReviewRepository instance = ReviewRepository._();

  final Map<String, List<Review>> _reviews = {
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

  List<Review> getReviews(String albumId) =>
      List.unmodifiable(_reviews[albumId] ?? []);

  void addOrUpdateMyReview(String albumId, Review review) {
    final list = List<Review>.from(_reviews[albumId] ?? []);
    final idx = list.indexWhere((r) => r.isMine);
    if (idx >= 0) {
      list[idx] = review;
    } else {
      list.insert(0, review);
    }
    _reviews[albumId] = list;
  }

  Review? getMyReview(String albumId) {
    try {
      return (_reviews[albumId] ?? []).firstWhere((r) => r.isMine);
    } catch (_) {
      return null;
    }
  }

  bool hasMyReview(String albumId) => getMyReview(albumId) != null;
}
