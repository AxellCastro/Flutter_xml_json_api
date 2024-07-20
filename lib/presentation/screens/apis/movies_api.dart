import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tarea_login/presentation/screens/apis/movie.dart';
import 'package:http/http.dart' as http;

class MoviesApi extends StatefulWidget {
  const MoviesApi({super.key});

  @override
  State<MoviesApi> createState() => _MoviesApiState();
}

class _MoviesApiState extends State<MoviesApi> {
  Future<List<Movie>> _getMovies() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=a400052bf0ef67c9e107fa6370669647&language=es-MX'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> moviesData = data['results'];

      return moviesData
          .map((movieData) => Movie(
                title: movieData['title'],
                overview: movieData['overview'] ?? '',
                posterPath: (movieData['poster_path'] != 'no-poster')
                    ? 'https://image.tmdb.org/t/p/w500${movieData['poster_path']}'
                    : 'https://content.numetro.co.za/ui_images/no_poster.png',
              ))
          .toList();
    } else {
      throw Exception('Error de conexion');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loadApiMovies(),
    );
  }

  Widget _loadApiMovies() {
    return FutureBuilder<List<Movie>>(
      future: _getMovies(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data!;
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return Card(
                color: Colors.blue.shade100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: SizedBox(
                      width: 50,
                      height: double.infinity,
                      child: Image.network(
                        movie.posterPath,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    title: Text(
                      movie.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                    subtitle: Text(
                      movie.overview,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('${snapshot.error}'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
