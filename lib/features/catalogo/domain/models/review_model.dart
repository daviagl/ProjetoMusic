class Review {
  final String user;
  final double stars;
  final String text;
  final String date;
  final bool isMine;

  const Review({
    required this.user,
    required this.stars,
    required this.text,
    required this.date,
    this.isMine = false,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    user: json['user'] as String,
    stars: (json['stars'] as num).toDouble(),
    text: json['text'] as String,
    date: json['date'] as String,
    isMine: json['isMine'] as bool? ?? false,
  );

  Map<String, dynamic> toJson() => {
    'user': user,
    'stars': stars,
    'text': text,
    'date': date,
    'isMine': isMine,
  };

  Review copyWith({
    String? user,
    double? stars,
    String? text,
    String? date,
    bool? isMine,
  }) => Review(
    user: user ?? this.user,
    stars: stars ?? this.stars,
    text: text ?? this.text,
    date: date ?? this.date,
    isMine: isMine ?? this.isMine,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Review && other.user == user && other.date == date;

  @override
  int get hashCode => Object.hash(user, date);
}
