import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/movie_card.dart';
import '../models/movie_model.dart';
import '../services/movie_service.dart';
import '../services/favorites_provider.dart';
import '../widgets/aesthetic_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> _movies = [];
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    try {
      setState(() {
        _isLoading = true;
        _error = '';
      });
      
      final movieService = MovieService();
      final movies = await movieService.fetchTrendingMovies();
      
      setState(() {
        _movies = movies;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load movies. Please try again.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Movie Explorer',
        showBackButton: false,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error.isNotEmpty) {
      return AestheticEmptyState(
        icon: Icons.error_outline,
        title: 'Oops!',
        subtitle: _error,
        action: AestheticButton(
          text: 'Retry',
          onPressed: _loadMovies,
          isGradient: true,
          icon: Icons.refresh,
        ),
      );
    }

    if (_movies.isEmpty) {
      return const AestheticEmptyState(
        icon: Icons.movie_outlined,
        title: 'No Movies Found',
        subtitle: 'No movies available at the moment.',
      );
    }

    return RefreshIndicator(
      onRefresh: _loadMovies,
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: _movies.length,
        itemBuilder: (context, index) {
          final movie = _movies[index];
          return Consumer<FavoritesProvider>(
            builder: (context, favoritesProvider, child) {
              return MovieCard(
                movie: movie,
              );
            },
          );
        },
      ),
    );
  }
}