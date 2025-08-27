import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../models/movie_model.dart';
import '../services/favorites_provider.dart';
import '../widgets/aesthetic_widgets.dart';
import '../widgets/custom_appbar.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: movie.title,
        actions: [
          Consumer<FavoritesProvider>(
            builder: (context, favoritesProvider, child) {
              final isFavorite = favoritesProvider.isFavorite(movie);
              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  favoritesProvider.toggleFavorite(movie);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isFavorite
                            ? 'Removed from favorites'
                            : 'Added to favorites',
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie Poster and Basic Info
            AestheticCard(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Movie Poster
                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: movie.poster.isNotEmpty && movie.poster != 'N/A'
                          ? CachedNetworkImage(
                              imageUrl: movie.poster,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: Theme.of(context).colorScheme.surface,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: Theme.of(context).colorScheme.surface,
                                child: Icon(
                                  Icons.movie,
                                  size: 50,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            )
                          : Container(
                              color: Theme.of(context).colorScheme.surface,
                              child: Icon(
                                Icons.movie,
                                size: 50,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Movie Info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movie.year,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (movie.rating != 'N/A')
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              movie.rating,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '/10',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      const SizedBox(height: 8),
                      if (movie.runtime != 'N/A')
                        Text(
                          movie.runtime,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            // Movie Details
            if (movie.genre.isNotEmpty && movie.genre != 'N/A')
              _buildDetailSection(context, 'Genre', movie.genre),
            if (movie.plot.isNotEmpty && movie.plot != 'N/A')
              _buildDetailSection(context, 'Plot', movie.plot),
            if (movie.director.isNotEmpty && movie.director != 'N/A')
              _buildDetailSection(context, 'Director', movie.director),
            if (movie.actors.isNotEmpty && movie.actors != 'N/A')
              _buildDetailSection(context, 'Cast', movie.actors),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(BuildContext context, String title, String content) {
    return AestheticCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}