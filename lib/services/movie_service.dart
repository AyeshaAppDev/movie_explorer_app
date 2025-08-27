import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class MovieService {
  // Replace with your actual OMDb API key from http://www.omdbapi.com/apikey.aspx
  static const String _apiKey = 'b8f3c7e2'; // Replace YOUR_OMDB_API_KEY with this
  static const String _baseUrl = 'http://www.omdbapi.com/';

  // Fetch 50 popular movies (hardcoded list for reliable display)
  static Future<List<Movie>> fetchTrendingMovies() async {
    final List<Map<String, String>> popularMovies = [
      {'title': 'The Shawshank Redemption', 'year': '1994', 'poster': 'https://m.media-amazon.com/images/M/MV5BNDE3ODcxYzMtY2YzZC00NmNlLWJiNDMtZDViZWM2MzIxZDYwXkEyXkFqcGdeQXVyNjAwNDUxODI@._V1_SX300.jpg'},
      {'title': 'The Godfather', 'year': '1972', 'poster': 'https://m.media-amazon.com/images/M/MV5BM2MyNjYxNmUtYTAwNi00MTYxLWJmNWYtYzZlODY3ZTk3OTFlXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg'},
      {'title': 'The Dark Knight', 'year': '2008', 'poster': 'https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_SX300.jpg'},
      {'title': 'The Godfather Part II', 'year': '1974', 'poster': 'https://m.media-amazon.com/images/M/MV5BMWMwMGQzZTItY2JlNC00OWZiLWIyMDctNDk2ZDQ2YjRjMWQ0XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg'},
      {'title': '12 Angry Men', 'year': '1957', 'poster': 'https://m.media-amazon.com/images/M/MV5BMWU4N2FjNzYtNTVkNC00NzQ0LTg0MjAtYTJlMjFhNGUxZDFmXkEyXkFqcGdeQXVyNjc1NTYyMjg@._V1_SX300.jpg'},
      {'title': 'Schindlers List', 'year': '1993', 'poster': 'https://m.media-amazon.com/images/M/MV5BNDE4OTMxMTctNmRhYy00NWE2LTg3YzItYTk3M2UwOTU5Njg4XkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg'},
      {'title': 'The Lord of the Rings: The Return of the King', 'year': '2003', 'poster': 'https://m.media-amazon.com/images/M/MV5BNzA5ZDNlZWMtM2NhNS00NDJjLTk4NDItYTRmY2EwMWI5MTktXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg'},
      {'title': 'Pulp Fiction', 'year': '1994', 'poster': 'https://m.media-amazon.com/images/M/MV5BNGNhMDIzZTUtNTBlZi00MTRlLWFjM2ItYzViMjE3YzI5MjljXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg'},
      {'title': 'The Lord of the Rings: The Fellowship of the Ring', 'year': '2001', 'poster': 'https://m.media-amazon.com/images/M/MV5BN2EyZjM3NzUtNWUzMi00MTgxLWI0NTctMzY4M2VlOTdjZWRiXkEyXkFqcGdeQXVyNDUzOTQ5MjY@._V1_SX300.jpg'},
      {'title': 'The Good, the Bad and the Ugly', 'year': '1966', 'poster': 'https://m.media-amazon.com/images/M/MV5BNjJlYmNkZGItM2NhYy00MjlmLTk5NmQtNjg1NmM2ODU4OTMwXkEyXkFqcGdeQXVyMjUzOTY1NTc@._V1_SX300.jpg'},
      {'title': 'Forrest Gump', 'year': '1994', 'poster': 'https://m.media-amazon.com/images/M/MV5BNWIwODRlZTUtY2U3ZS00Yzg1LWJhNzYtMmZiYmEyNmU1NjMzXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg'},
      {'title': 'Fight Club', 'year': '1999', 'poster': 'https://m.media-amazon.com/images/M/MV5BMmEzNTkxYjQtZTc0MC00YTVjLTg5ZTEtZWMwOWVlYzY0NWIwXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg'},
      {'title': 'The Lord of the Rings: The Two Towers', 'year': '2002', 'poster': 'https://m.media-amazon.com/images/M/MV5BZGMxZTdjZmYtMmE2Ni00ZTdkLWI5NTgtNjlmMjBiNzU2MmI5XkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg'},
      {'title': 'Inception', 'year': '2010', 'poster': 'https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_SX300.jpg'},
      {'title': 'Star Wars: Episode V - The Empire Strikes Back', 'year': '1980', 'poster': 'https://m.media-amazon.com/images/M/MV5BYmU1NDRjNDgtMzhiMi00NjZmLTg5NGItZDNiZjU5NTU4OTE0XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg'},
      {'title': 'The Matrix', 'year': '1999', 'poster': 'https://m.media-amazon.com/images/M/MV5BNzQzOTk3OTAtNDQ0Zi00ZTVkLWI0MTEtMDllZjNkYzNjNTc4L2ltYWdlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg'},
      {'title': 'Goodfellas', 'year': '1990', 'poster': 'https://m.media-amazon.com/images/M/MV5BY2NkZjEzMDgtN2RjYy00YzM1LWI4ZmQtMjIwYjFjNmI3ZGEwXkEyXkFqcGdeQXVyNDk3NzU2MTQ@._V1_SX300.jpg'},
      {'title': 'One Flew Over the Cuckoos Nest', 'year': '1975', 'poster': 'https://m.media-amazon.com/images/M/MV5BZjA0OWVhOTAtYWQxNi00YzNhLWI4ZjYtNjFjZTEyYjJlNDVlL2ltYWdlL2ltYWdlXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg'},
      {'title': 'Se7en', 'year': '1995', 'poster': 'https://m.media-amazon.com/images/M/MV5BOTUwODM5MTctZjczMi00OTk4LTg3NWUtNmVhMTAzNTNjYjcyXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg'},
      {'title': 'Seven Samurai', 'year': '1954', 'poster': 'https://m.media-amazon.com/images/M/MV5BOWQ4NzQxNDEtNWU2Mi00MjFiLWJlNzEtNTRkNzk3ZjY2YTVjXkEyXkFqcGdeQXVyNjc1NTYyMjg@._V1_SX300.jpg'},
      {'title': 'The Silence of the Lambs', 'year': '1991', 'poster': 'https://m.media-amazon.com/images/M/MV5BNjNhZTk0ZmEtNjJhMi00YzFlLWE1MmEtYzM1M2ZmMGMwMTU4XkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg'},
      {'title': 'City of God', 'year': '2002', 'poster': 'https://m.media-amazon.com/images/M/MV5BMjA4ODQ3ODkzNV5BMl5BanBnXkFtZTYwOTc4NDI3._V1_SX300.jpg'},
      {'title': 'Its a Wonderful Life', 'year': '1946', 'poster': 'https://m.media-amazon.com/images/M/MV5BZjc4NDZhZWMtNGEzYS00ZWU2LThlM2ItNTA0YzQ0OTExMTE2XkEyXkFqcGdeQXVyNjUwMzI2NzU@._V1_SX300.jpg'},
      {'title': 'Life Is Beautiful', 'year': '1997', 'poster': 'https://m.media-amazon.com/images/M/MV5BYmJmM2Q4NmMtYThmNC00ZjRlLWEyZmItZTIwOTBlZDQ3NTQ1XkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg'},
      {'title': 'The Usual Suspects', 'year': '1995', 'poster': 'https://m.media-amazon.com/images/M/MV5BYTViNzMxZjEtZGEwNy00MDNiLWIzNGQtZDY2MjQ1OWViZjFmXkEyXkFqcGdeQXVyNzQ1ODk3MTQ@._V1_SX300.jpg'},
      {'title': 'Léon: The Professional', 'year': '1994', 'poster': 'https://m.media-amazon.com/images/M/MV5BOTgyMWQ0ZWUtN2Q2MS00OWM2LWI3NmYtNWY0ZDI0ZjEyZGU1XkEyXkFqcGdeQXVyMjUzOTY1NTc@._V1_SX300.jpg'},
      {'title': 'Spirited Away', 'year': '2001', 'poster': 'https://m.media-amazon.com/images/M/MV5BMjlmZmI5MDctNDE2YS00YWE0LWE5ZWItZDBhYWQ0NTcxNWRhXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg'},
      {'title': 'Saving Private Ryan', 'year': '1998', 'poster': 'https://m.media-amazon.com/images/M/MV5BZjhkMDM4MWItZTVjOC00ZDRhLThmYTAtM2I5NzBmNmNlMzI1XkEyXkFqcGdeQXVyNDYyMDk5MTU@._V1_SX300.jpg'},
      {'title': 'Interstellar', 'year': '2014', 'poster': 'https://m.media-amazon.com/images/M/MV5BZjdkOTU3MDktN2IxOS00OGEyLWFmMjktY2FiMmZkNWIyODZiXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg'},
      {'title': 'American History X', 'year': '1998', 'poster': 'https://m.media-amazon.com/images/M/MV5BZTJhN2FkYWEtMGI0My00YWM4LWI2MjAtM2UwNjY4MTI2ZTQyXkEyXkFqcGdeQXVyNjc3MjQzNTI@._V1_SX300.jpg'},
      {'title': 'Casablanca', 'year': '1942', 'poster': 'https://m.media-amazon.com/images/M/MV5BY2IzZGY2YmEtYzljNS00NTM5LTgwMzUtMzM1NjQ4NGI0OTk0XkEyXkFqcGdeQXVynDYyMDk5MTU@._V1_SX300.jpg'},
      {'title': 'Psycho', 'year': '1960', 'poster': 'https://m.media-amazon.com/images/M/MV5BNTQwNDM1YzItNDAxZC00NWY2LTk0M2UtNDIwNWI5OGUyNWUxXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg'},
      {'title': 'City Lights', 'year': '1931', 'poster': 'https://m.media-amazon.com/images/M/MV5BY2Q2NzQ3ZDUtNWU5OC00Yjg0LThkMmQtZjE5ZjA2NWM5NzFjXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg'},
      {'title': 'The Green Mile', 'year': '1999', 'poster': 'https://m.media-amazon.com/images/M/MV5BMTUxMzQyNjA5MF5BMl5BanBnXkFtZTYwOTU2NTY3._V1_SX300.jpg'},
      {'title': 'Raiders of the Lost Ark', 'year': '1981', 'poster': 'https://m.media-amazon.com/images/M/MV5BNTU2ODkyY2MtMjU1NC00NjE1LWEzYjgtMWQ3MzI1ODc5Nzk4XkEyXkFqcGdeQXVyMjM4NTM5NDY@._V1_SX300.jpg'},
      {'title': 'The Intouchables', 'year': '2011', 'poster': 'https://m.media-amazon.com/images/M/MV5BMTYxNDA3MDQwNl5BMl5BanBnXkFtZTcwNTU4Mzc1Nw@@._V1_SX300.jpg'},
      {'title': 'Modern Times', 'year': '1936', 'poster': 'https://m.media-amazon.com/images/M/MV5BYjJiZjMzYzktNjU0NS00OTkxLWEwYzItYzdhYWJjN2QzMTRlL2ltYWdlL2ltYWdlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg'},
      {'title': 'Rear Window', 'year': '1954', 'poster': 'https://m.media-amazon.com/images/M/MV5BNGUxYWM3M2MtMGM3Mi00ZmRiLWE0NGQtZjE5ODI2OTJhNTU0XkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg'},
      {'title': 'The Pianist', 'year': '2002', 'poster': 'https://m.media-amazon.com/images/M/MV5BOWRiZDIxZjktMTA1NC00MDQ2LWEzMjUtMTliZmY3NjQ3ODJiXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg'},
      {'title': 'The Departed', 'year': '2006', 'poster': 'https://m.media-amazon.com/images/M/MV5BMTI1MTY2OTIxNV5BMl5BanBnXkFtZTYwNjQ4NjY3._V1_SX300.jpg'},
      {'title': 'Terminator 2: Judgment Day', 'year': '1991', 'poster': 'https://m.media-amazon.com/images/M/MV5BMGU2NzRmZjUtOGUxYS00ZjdjLWEwZWItY2NlM2JhNjkxNTFmXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg'},
      {'title': 'Back to the Future', 'year': '1985', 'poster': 'https://m.media-amazon.com/images/M/MV5BZmU0M2Y1OGUtZjIxNi00ZjBkLTg1MjgtOWIyNThiZWIwYjRiXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg'},
      {'title': 'Whiplash', 'year': '2014', 'poster': 'https://m.media-amazon.com/images/M/MV5BOTA5NDZlZGUtMjAxOS00YTRkLTkwYmMtYWQ0NWEwZDZiNjEzXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg'},
      {'title': 'Gladiator', 'year': '2000', 'poster': 'https://m.media-amazon.com/images/M/MV5BMDliMmNhNDEtODUyOS00MjNlLTgxODEtN2U3NzIxMGVkZTA1L2ltYWdlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg'},
      {'title': 'The Prestige', 'year': '2006', 'poster': 'https://m.media-amazon.com/images/M/MV5BMjA4NDI0MTIxNF5BMl5BanBnXkFtZTYwNTM0MzY2._V1_SX300.jpg'},
      {'title': 'The Lion King', 'year': '1994', 'poster': 'https://m.media-amazon.com/images/M/MV5BYTYxNGMyZTYtMjE3MS00MzNjLWFjNmYtMDk3N2FmM2JiM2M1XkEyXkFqcGdeQXVyNjY5NDU4NzI@._V1_SX300.jpg'},
      {'title': 'Memento', 'year': '2000', 'poster': 'https://m.media-amazon.com/images/M/MV5BZTcyNjk1MjgtOWI3Mi00YzQwLWI5MTktMzY4ZmI2NDAyNzYzXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg'},
      {'title': 'Apocalypse Now', 'year': '1979', 'poster': 'https://m.media-amazon.com/images/M/MV5BMDdhYmNhN2EtZjNmZC00MDQyLWE2MmYtZmUyN2NlOGE0ZWQxXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg'},
      {'title': 'Alien', 'year': '1979', 'poster': 'https://m.media-amazon.com/images/M/MV5BOGQzZTBjMjQtOTVmMS00NGE5LWEyYmMtOGQ1ZGZjNmRkYjFhXkEyXkFqcGdeQXVyMjUzOTY1NTc@._V1_SX300.jpg'},
      {'title': 'Sunset Boulevard', 'year': '1950', 'poster': 'https://m.media-amazon.com/images/M/MV5BMTU0NTkyNzYwMF5BMl5BanBnXkFtZTgwMDU0NDk5MTI@._V1_SX300.jpg'}
    ];

    List<Movie> movies = [];
    
    for (var movieData in popularMovies) {
      movies.add(Movie(
        id: 'tt${movies.length + 1000000}', // Generate fake IMDb ID
        title: movieData['title']!,
        year: movieData['year']!,
        poster: movieData['poster']!,
        plot: 'A classic movie that has captivated audiences worldwide.',
        director: 'Various Directors',
        actors: 'Various Actors',
        genre: 'Drama, Action',
        rating: '8.5', // Changed from imdbRating to rating
        released: 'Various Dates',
        runtime: '120 min',
      ));
    }
    
    return movies;
  }

  // Search movies with pagination
  static Future<List<Movie>> searchMovies(String query, {int page = 1}) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl?apikey=$_apiKey&s=$query&page=$page'),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['Response'] == 'True') {
          List<Movie> movies = [];
          for (var movieData in data['Search']) {
            // Get detailed info for each movie
            final detailResponse = await http.get(
              Uri.parse('$_baseUrl?apikey=$_apiKey&i=${movieData['imdbID']}'),
            );
            
            if (detailResponse.statusCode == 200) {
              final detailData = json.decode(detailResponse.body);
              if (detailData['Response'] == 'True') {
                movies.add(Movie.fromJson(detailData));
              }
            }
          }
          return movies;
        }
      }
    } catch (e) {
      print('Error searching movies: $e');
    }
    
    return [];
  }

  // Get movie details by ID
  static Future<Movie?> getMovieDetails(String imdbId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl?apikey=$_apiKey&i=$imdbId'),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['Response'] == 'True') {
          return Movie.fromJson(data);
        }
      }
    } catch (e) {
      print('Error fetching movie details: $e');
    }
    
    return null;
  }
}