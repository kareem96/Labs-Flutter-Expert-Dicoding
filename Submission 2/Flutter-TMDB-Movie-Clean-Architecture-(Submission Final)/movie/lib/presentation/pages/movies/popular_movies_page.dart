


import 'package:core/presentation/widgets/card_list.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../bloc/popular/movie_popular_bloc.dart';

class PopularMoviesPage extends StatefulWidget {
  static const routeName = '/popular';
  const PopularMoviesPage({Key? key}) : super(key: key);

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    Future.microtask(() =>
        /*Provider.of<PopularMoviesNotifier>(context, listen: false).fetchPopularMovies());*/
    BlocProvider.of<MoviePopularBloc>(context, listen: false).add(OnMoviePopular()));

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popular Movies'),),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<MoviePopularBloc, MoviePopularState>(
            builder: (context, state) {
              if(state is MoviePopularLoading){
                return const CircularProgressIndicator();
              }else if(state is MoviePopularHasData){
                final data = state.result;
                return ListView.builder(
                    itemBuilder: (context, index) {
                      final movie = data[index];
                      return CardList(movie);
                    }
                );
              }else{
                return Center(
                  key: const Key("error_message"),
                  child: Text((state as MoviePopularError).message),
                );
              }
            }),
        /*child: Consumer<PopularMoviesNotifier>(
          builder: (context, data, child){
            if(data.state == RequestState.Loading){
              return const Center(child: CircularProgressIndicator(),);
            }else if(data.state == RequestState.Loaded){
              return ListView.builder(
                itemCount: data.movies.length,
                itemBuilder: (context, index){
                  final movie = data.movies[index];
                  return CardList(movie);
                },
              );
            }else{
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),*/
      ),
    );
  }
}
