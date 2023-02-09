import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movie_app/Model/model.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/widgets/movie_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> _movies = [];

  Future _fetchMovies() async {
    final response = await http.get(
        Uri.parse('https://imdb-api.com/en/API/MostPopularMovies/k_cbi751rg'));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result["items"];
      return list.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception('failed to load');
    }
  }

  void popularMovies() async {
    final myMovies = await _fetchMovies();
    setState(() {
      _movies.addAll(myMovies);
    });
    //print(_movies[1].title);
  }

  @override
  Widget build(BuildContext context) {
    popularMovies();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Top Movies'),
        ),
        body: _movies.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 30,
                ),
                itemBuilder: (ctx, i) => MovieItem(
                  title: _movies[i].title!,
                  imageurl: _movies[i].image!,
                  id: _movies[i].id!,
                ),
                itemCount: _movies.length,
                padding: EdgeInsets.all(10),
              ));
  }
}
