import 'package:app_clean_architecture_flutter/presentation/provider/top_rated_movies_notifier.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/card_list.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const routeName = '/top_rated_movies_page';

  const TopRatedMoviesPage({Key? key}) : super(key: key);

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() =>
        Provider.of<TopRatedMoviesNotifier>(context, listen: false)
            .fetchTopRatedMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Top Rated Movies'),),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Consumer<TopRatedMoviesNotifier>(
          builder: (context, provider, child) {
            if (provider.state == RequestState.Loading) {
              return const Center(child: CircularProgressIndicator(),);
            } else if (provider.state == RequestState.Loaded) {
              return ListView.builder(
                  itemCount:provider.movie.length,
                  itemBuilder: (context, index){
                    final movie = provider.movie[index];
                    return CardList(movie);
                  }
              );
            }else{
              return Center(
                key: const Key('error_message'),
                child: Text(provider.message),
              );
            }
          },
        ),
      ),
    );
  }
}
