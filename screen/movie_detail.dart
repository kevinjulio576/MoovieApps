import 'package:flutter/material.dart';
import '../model/movie.dart';

class MovieDetail extends StatelessWidget{
  final Movie selecetedMovie;
  const MovieDetail({Key? key, required this.selecetedMovie}) : super(key: key);

  @override
  Widget build(BuildContext context){
    String path;
    double screenHeight = MediaQuery.of(context).size.height;

    if(selecetedMovie.posterPath != null){
      path = 'https://image.tmdb.org/t/p/w500/${selecetedMovie.posterPath}';
    }else{
      path = 'https://img.freepik.com/premium-vector/clapper-film-movie-icon-design_24877-23150.jpg';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${selecetedMovie.title}'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16),
                height: screenHeight / 1.5,
                child: Image.network(path),
              ),
              Text('${selecetedMovie.overview}'),
            ],
          ),
        ),
      ));
  }
}