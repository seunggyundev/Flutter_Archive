import 'package:archive/src/model/movie.dart';
import 'package:archive/src/provider/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieListWidget extends StatelessWidget {
  MovieListWidget({Key? key}) : super(key: key);

  MovieProvider _movieProvider = MovieProvider();

  Widget _makeListView(List<Movie> movies) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Center(child: Text('${movies[index].title}'),);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
          );
        },
        itemCount: movies.length
    );
  }

  @override
  Widget build(BuildContext context) {
    _movieProvider = Provider.of<MovieProvider>(context, listen: false);
    _movieProvider.loadMovies();
    return Scaffold(
      appBar: AppBar(title: Text('movie provider'),),
      body: Consumer<MovieProvider>(
        builder: (context, provider, widget){
          if (provider.movies != null && provider.movies.length > 0) {
            return _makeListView(provider.movies);
          }
          return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}
