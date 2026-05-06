class Album {
  final String id;
  final String abbr;
  final String title;
  final String artist;
  final int year;
  final double rating;
  final String ratingCount;
  final String genre;
  final String about;
  final int colorValue;

  const Album({
    required this.id,
    required this.abbr,
    required this.title,
    required this.artist,
    required this.year,
    required this.rating,
    required this.ratingCount,
    required this.genre,
    required this.about,
    required this.colorValue,
  });

  factory Album.fromJson(Map<String, dynamic> json) => Album(
    id: json['id'] as String,
    abbr: json['abbr'] as String,
    title: json['title'] as String,
    artist: json['artist'] as String,
    year: json['year'] as int,
    rating: (json['rating'] as num).toDouble(),
    ratingCount: json['ratingCount'] as String,
    genre: json['genre'] as String,
    about: json['about'] as String,
    colorValue: json['colorValue'] as int,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'abbr': abbr,
    'title': title,
    'artist': artist,
    'year': year,
    'rating': rating,
    'ratingCount': ratingCount,
    'genre': genre,
    'about': about,
    'colorValue': colorValue,
  };

  Album copyWith({
    String? id,
    String? abbr,
    String? title,
    String? artist,
    int? year,
    double? rating,
    String? ratingCount,
    String? genre,
    String? about,
    int? colorValue,
  }) => Album(
    id: id ?? this.id,
    abbr: abbr ?? this.abbr,
    title: title ?? this.title,
    artist: artist ?? this.artist,
    year: year ?? this.year,
    rating: rating ?? this.rating,
    ratingCount: ratingCount ?? this.ratingCount,
    genre: genre ?? this.genre,
    about: about ?? this.about,
    colorValue: colorValue ?? this.colorValue,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Album && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
