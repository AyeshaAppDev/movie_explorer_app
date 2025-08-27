class Movie {
  final String id;
  final String title;
  final String year;
  final String poster;
  final String plot;
  final String director;
  final String actors;
  final String genre;
  final String rating; // Changed from imdbRating to rating
  final String released;
  final String runtime;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.poster,
    required this.plot,
    required this.director,
    required this.actors,
    required this.genre,
    required this.rating, // Changed from imdbRating to rating
    required this.released,
    required this.runtime,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['imdbID'] ?? '',
      title: json['Title'] ?? '',
      year: json['Year'] ?? '',
      poster: json['Poster'] ?? '',
      plot: json['Plot'] ?? '',
      director: json['Director'] ?? '',
      actors: json['Actors'] ?? '',
      genre: json['Genre'] ?? '',
      rating: json['imdbRating'] ?? '', // Changed from imdbRating to rating
      released: json['Released'] ?? '',
      runtime: json['Runtime'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imdbID': id,
      'Title': title,
      'Year': year,
      'Poster': poster,
      'Plot': plot,
      'Director': director,
      'Actors': actors,
      'Genre': genre,
      'imdbRating': rating, // Changed from imdbRating to rating
      'Released': released,
      'Runtime': runtime,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Movie && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}