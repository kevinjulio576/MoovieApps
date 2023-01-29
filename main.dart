import 'package:flutter/material.dart';
import 'package:movielist/screen/movie_list.dart';
import 'package:movielist/screen/movie_list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MovieListView(),
    );
  }
}
