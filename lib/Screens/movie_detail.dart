import 'package:flutter/material.dart';

class MovieDetail extends StatelessWidget {
  MovieDetail({super.key});
  static const routeName = 'movie_detail';

  var _title;
  var _id;
  var _imageUrl;
  var _year;
  var _crew;
  var _rating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Center(
          child: Text(
        'detail screen',
      )),
    );
  }
}
