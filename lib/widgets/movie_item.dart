import 'package:flutter/material.dart';
import 'package:movie_app/Screens/movie_detail.dart';

class MovieItem extends StatelessWidget {
  final String? title;
  final String? imageurl;
  final String? id;
  const MovieItem({
    super.key,
    required this.title,
    required this.imageurl,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: GridTile(
        child: Image.network(
          imageurl!,
          fit: BoxFit.cover,
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
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            title!,
            textAlign: TextAlign.start,
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).pushNamed(MovieDetail.routeName);
      },
    );
  }
}
