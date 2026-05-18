enum StarRating {
  uma(1),
  duas(2),
  tres(3),
  quatro(4),
  cinco(5);

  final int value;
  const StarRating(this.value);

  static StarRating fromInt(int v) => StarRating.values.firstWhere(
    (e) => e.value == v,
    orElse: () => StarRating.tres,
  );

  String get label {
    switch (this) {
      case StarRating.uma:
        return 'Horrível';
      case StarRating.duas:
        return 'Ruim';
      case StarRating.tres:
        return 'Ok';
      case StarRating.quatro:
        return 'Bom';
      case StarRating.cinco:
        return 'Excelente';
    }
  }
}

enum Genre {
  rock('Rock'),
  metal('Metal'),
  grunge('Grunge'),
  classicRock('Classic Rock'),
  punk('Punk'),
  altRock('Alt Rock');

  final String label;
  const Genre(this.label);

  static Genre? fromLabel(String label) {
    try {
      return Genre.values.firstWhere((e) => e.label == label);
    } catch (_) {
      return null;
    }
  }
}

enum AuthStatus { unauthenticated, authenticated }
