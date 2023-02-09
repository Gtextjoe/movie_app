import 'package:flutter/material.dart';

class Movie {
  final String? title;
  final String? image;
  final String? id;

  Movie({
    required this.title,
    required this.image,
    required this.id,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'] as String?,
      image: json['image'],
      id: json['id'],
    );
  }
}
