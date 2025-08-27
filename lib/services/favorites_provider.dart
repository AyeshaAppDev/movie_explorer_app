import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/movie_model.dart';

class FavoritesProvider with ChangeNotifier {
  List<Movie> _favorites = [];
  static const String _favoritesKey = 'favorite_movies';

  List<Movie> get favorites => _favorites;

  FavoritesProvider() {
    _loadFavorites();
  }

  // Load favorites from SharedPreferences
  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = prefs.getStringList(_favoritesKey) ?? [];
      
      _favorites = favoritesJson
          .map((jsonString) => Movie.fromJson(json.decode(jsonString)))
          .toList();
      
      notifyListeners();
    } catch (e) {
      print('Error loading favorites: $e');
    }
  }

  // Save favorites to SharedPreferences
  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = _favorites
          .map((movie) => json.encode(movie.toJson()))
          .toList();
      
      await prefs.setStringList(_favoritesKey, favoritesJson);
    } catch (e) {
      print('Error saving favorites: $e');
    }
  }

  // Check if movie is favorite
  bool isFavorite(Movie movie) {
    return _favorites.any((fav) => fav.id == movie.id);
  }

  // Add to favorites
  Future<void> addFavorite(Movie movie) async {
    if (!isFavorite(movie)) {
      _favorites.add(movie);
      await _saveFavorites();
      notifyListeners();
    }
  }

  // Toggle favorite status
  Future<void> toggleFavorite(Movie movie) async {
    if (isFavorite(movie)) {
      _favorites.removeWhere((fav) => fav.id == movie.id);
    } else {
      _favorites.add(movie);
    }
    
    await _saveFavorites();
    notifyListeners();
  }

  // Remove from favorites
  Future<void> removeFavorite(Movie movie) async {
    _favorites.removeWhere((fav) => fav.id == movie.id);
    await _saveFavorites();
    notifyListeners();
  }

  // Clear all favorites
  Future<void> clearFavorites() async {
    _favorites.clear();
    await _saveFavorites();
    notifyListeners();
  }
}