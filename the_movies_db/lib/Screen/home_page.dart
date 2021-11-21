import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_movies_db/Model/movie.dart';
import 'package:the_movies_db/Network/movie_service_api.dart';
import 'package:the_movies_db/Screen/movie_detail.dart';

class HomePage extends StatefulWidget {
  final String title;
  HomePage({Key? key, required this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie> movies = List.empty(growable: true);
  MovieServiceApi serviceApi = MovieServiceApi();
  bool isSearching = false;

  @override
  void initState() {
    serviceApi.getUpcomingMovie().then((value) {
      setState(() {
        movies = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff009688),
          title: !isSearching ? Text(widget.title) : TextField(
            textInputAction: TextInputAction.search,
            style: TextStyle(color: Colors.white,fontSize: 18),
            decoration: InputDecoration(border: InputBorder.none, hintText: 'Search'),
            autofocus: true,
            onSubmitted: (String text) => search(text),
          ),
          actions: [
            IconButton(
              icon: !isSearching ? Icon(Icons.search) : Icon(Icons.cancel),
              onPressed: () {
                setState(() {
                   isSearching = !isSearching;
                });
              },)
          ],),
        body: ListView.builder(
            itemCount: movies.length,
            itemBuilder: (BuildContext context, int position) {
              return Card(
                color: Colors.white,
                elevation: 2.0,
                child: ListTile(
                  title: Text(movies[position].title),
                  leading: CircleAvatar(
                    backgroundImage: getAvatarImage(movies[position]),
                  ),
                  subtitle: Text('Released: '
                      + movies[position].releaseDate + ' - Vote: ' +
                      movies[position].voteAverage.toString()),
                  onTap: (){
                    MaterialPageRoute route = MaterialPageRoute(builder: (context) => MovieDetail(movie: movies[position]));
                    Navigator.of(context).push(route);
                  },
                ),
              );
            }
        )
    );
  }

  NetworkImage getAvatarImage(Movie movie){
    const String defaultImage = 'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
    const String ICON_BASE = 'https://image.tmdb.org/t/p/w92/';
    
    return (movie.posterPath != null ) ? NetworkImage(ICON_BASE + movie.posterPath!) : NetworkImage(defaultImage);
  }

  void search(String title){
      serviceApi.searchMovie(title).then((value){
        setState(() {
          movies = value;
        });
      });
  }
}
