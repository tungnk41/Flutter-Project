import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_movies_db/Model/movie.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;
  const MovieDetail({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                height: height/2,
                child: getPosterImage(movie),
              ),
              Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Text(movie.overView)
              )
            ],
          ),
        ),
      ),
    );
  }

  Image getPosterImage(Movie movie){
    const String defaultImage = 'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
    const String ICON_BASE = 'https://image.tmdb.org/t/p/w500/';

    return (movie.posterPath != null ) ? Image.network(ICON_BASE + movie.posterPath!) : Image.network(defaultImage);
  }
}
