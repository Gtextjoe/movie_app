import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MovieDetail extends StatelessWidget {
  static const routeName = 'movie_detail';

  var _title;
  var _id;
  var _imageUrl;
  var _year;
  var _crew;
  var _rating;

  Future _fetchDetails(String id) async {
    final response = await http.get(Uri.parse(
        'https://imdb-api.com/en/API/MostPopularMovies/k_cbi751rg$id'));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final list = result['items'];

      _title = list['fullTitle'];
      _id = list['id'];
      _imageUrl = list['image'];
      _year = list['year'];
      _crew = list['crew'];
      _rating = list['imDbRating'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final _movieId = ModalRoute.of(context)!.settings.toString();

    return FutureBuilder(
      future: _fetchDetails(_movieId),
      builder: (context, data) {
        while (_id == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(_title),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: 10,
                        top: 10,
                      ),
                      width: 200,
                      child: Image.network(
                        _imageUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.white,
                            child: LayoutBuilder(
                              builder: (context, constraint) {
                                return Icon(
                                  Icons.error_outline_sharp,
                                  color: Colors.red,
                                  size: constraint.biggest.width,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 50),
                    Column(
                      children: [
                        SizedBox(height: 20),
                        CircleAvatar(
                          backgroundColor: Color(0xFFFFC400),
                          child: Text(
                            double.parse(_rating.toString()).toStringAsFixed(1),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Crew: ',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(height: 20),
                        for (var i in _crew)
                          Column(
                            children: [
                              Text(i.toString()),
                              SizedBox(height: 10),
                            ],
                          ),
                        SizedBox(height: 20),
                        Text(
                          'Released: ',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(_year.toString())
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
