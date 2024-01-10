import 'package:flutter/material.dart';

import 'package:uas_coba/Api_json/api/movie_api.dart';
import 'package:uas_coba/Api_json/screens/anime_detail_screen.dart.dart';
import 'package:uas_coba/Api_json/widgets/anime_tile.dart';

class Api extends StatefulWidget {
  const Api({super.key});

  @override
  State<Api> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Api> {
  @override
  void initState() {
    MovieApi.fetchAnimes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MovieApi.fetchAnimes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.data != null) {
          final animes = snapshot.data!;

          return Scaffold(
            appBar: AppBar(title: const Text('Movie List')),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              child: ListView.builder(
                itemCount: animes.length,
                itemBuilder: (context, index) {
                  final anime = animes.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => AnimeDetailScreen(
                            anime: anime,
                          ),
                        ),
                      );
                    },
                    child: AnimeTile(anime: anime),
                  );
                },
              ),
            ),
          );
        }

        return Center(
          child: Text(
            snapshot.error.toString(),
          ),
        );
      },
    );
  }
}
