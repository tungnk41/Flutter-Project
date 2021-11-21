import 'package:flutter/material.dart';
import 'package:the_movies_db/Network/movie_service_api.dart';

import 'Model/movie.dart';
import 'Screen/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: "The Movies DB",),
    );
  }
}
