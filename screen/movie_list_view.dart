import 'package:flutter/material.dart';
import 'package:movielist/helper/http_helper.dart';
import 'package:movielist/screen/movie_detail.dart';


class MovieListView extends StatefulWidget { //2
  const MovieListView({Key? key}) : super(key: key);
  @override
  State<MovieListView> createState() => _MovieListViewState();
}
class _MovieListViewState extends State<MovieListView> {//3

  Icon searchIcon = Icon(Icons.search);
  Widget titlebar = Text('Daftar Film');

  late int moviesCount;
  late List movies;
  late HttpHelper helper;
  //tambahan iconBase
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage = 'https://images.freeimages.com/images/large-previews/5eb/movie-clap board-1184339.jpg';

  @override
  void initState() { //4
    defaultList();
    super.initState();
  }

  void toggleSearch() {
    setState(() {
      if(this.searchIcon.icon == Icons.search){
        this.searchIcon = Icon(Icons.cancel);
        this.titlebar = TextField(
          autofocus: true,
          onSubmitted: (text){
            searchMovies(text);
          },
          decoration: InputDecoration(hintText: 'Ketik kata pencarian'),
          textInputAction: TextInputAction.search,
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.0
          ),
        );
      }else{
        setState(() {
          this.searchIcon = Icon(Icons.search);
          this.titlebar = Text('Daftar Film');
        });
        defaultList();
      }
    });
  }

  Future<List> searchMovies(String text) async{
    List searchedMovies = await helper.findMovies(text);
    setState(() {
      movies = searchedMovies;
      moviesCount = movies.length;
    });
  }

  Future defaultList() async { //5
    moviesCount = 0;
    movies = [];
    helper = HttpHelper();
    List moviesFromAPI = [];
    moviesFromAPI = await helper.getUpComingAsList();
    setState(() {
      movies = moviesFromAPI;
      moviesCount = movies.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image; //tambahan image
    return Scaffold(
      appBar: AppBar(
        title: titlebar,
        actions: [
          IconButton(
            icon: searchIcon,
            onPressed: toggleSearch,
          )
        ],
      ),
      body: ListView.builder( //6
        itemCount: moviesCount,
        itemBuilder: (context, position) {
          // tambahan kode untuk akses image pada url
          if (movies[position].posterPath != null) {
            image = NetworkImage(iconBase + movies[position].posterPath);
          } else {
            image = NetworkImage(defaultImage);
          }
          //=============================
          return Card( //7
            elevation: 2,
            child: ListTile( //8
              onTap: () { //1
                MaterialPageRoute route = MaterialPageRoute( //2
                  builder: (context) {
                    return MovieDetail(selecetedMovie: movies[position],);
                  },
                );
                Navigator.push(context, route); //3
              },
              leading: CircleAvatar( // leading adalah kolom di depan title
                backgroundImage: image,
              ),
              title: Text(movies[position].title),
              subtitle: Text(
                'Released: ' +
                    movies[position].releaseDate +
                    ' - Vote: ' +
                    movies[position].voteAverage.toString(),
              ),
            ),
          );
        },
      ),
    );
  }

}