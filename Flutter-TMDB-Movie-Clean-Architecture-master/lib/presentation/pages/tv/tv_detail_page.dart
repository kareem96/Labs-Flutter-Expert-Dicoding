


import 'package:app_clean_architecture_flutter/domain/entities/tv/tv_detail.dart';
import 'package:app_clean_architecture_flutter/presentation/provider/tv/tv_detail_notifier.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../common/constant.dart';
import '../../../common/state_enum.dart';
import '../../../data/model/tv/tv_detail_model.dart';

class TvDetailPage extends StatefulWidget {
  static const routeName = '/page_detail_tv';
  final int id;
  const TvDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TvDetailNotifier>(context, listen: false).fetchTvDetail(widget.id);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.tvDetailState == RequestState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.tvDetailState == RequestState.Loaded) {
            final movie = provider.tvDetail;
            return SafeArea(
              child: ContentDetails(
                movie,
                /*provider.isAddedToWatchlist,
                provider.movieRecommendations,*/
              ),
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}


class ContentDetails extends StatelessWidget {
  final TvDetail tvDetail;
  /*final bool isAddedWatchlist;
  final List<Tv> recommendations;*/
  ContentDetails(
      this.tvDetail,
      /*this.isAddedWatchlist,
      this.recommendations*/
      );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvDetail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 10),
          child: DraggableScrollableSheet(
            builder: (context, scrollController){
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tvDetail.name),
                            /*ElevatedButton(
                                onPressed: ()async{
                                  if(!isAddedWatchlist){
                                    await Provider.of<MovieDetailNotifier>(context, listen: false).addWatchlist(movie);
                                  }else{
                                    await Provider.of<MovieDetailNotifier>(context, listen: false).removeFromWatchlist(movie);
                                  }
                                  final message = Provider.of<MovieDetailNotifier>(context, listen: false).watchlistMessage;
                                  if(message == MovieDetailNotifier.watchlistAddSuccessMessage || message == MovieDetailNotifier.watchlistRemoveSuccessMessage){
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                                  }else{
                                    showDialog(
                                        context: context,
                                        builder: (context){
                                          return AlertDialog(
                                            content: Text(message),
                                          );
                                        }
                                    );
                                  }
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    isAddedWatchlist ? const Icon(Icons.check) : const Icon(Icons.add),
                                    const Text('Watchlist')
                                  ],
                                )
                            ),*/
                            Text(_showGenres(tvDetail.genres)),
                            // Text(_showDuration(tvDetail.runtime!)),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvDetail.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(Icons.star),
                                  itemSize: 24,
                                ),
                                Text('${tvDetail.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16,),
                            Text('Overview', style: Heading6,),
                            Text(tvDetail.overview),
                            const SizedBox(height: 16,),
                            Text('Recommendations', style: Heading6,),
                            /*Consumer<TvDetailNotifier>(
                              builder: (context, data, child){
                                if(data.recommenddationsState == RequestState.Loading){
                                  return const Center(child: CircularProgressIndicator(),);
                                }else if(data.recommenddationsState == RequestState.Error){
                                  return Text(data.message);
                                }else if(data.recommenddationsState == RequestState.Loaded){
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: recommendations.length,
                                      itemBuilder: (context, index){
                                        final movie = recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: (){
                                              Navigator.pushReplacementNamed(
                                                  context,
                                                  MovieDetailPage.routeName,
                                                  arguments: movie.id
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                                              child: CachedNetworkImage(
                                                imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                placeholder: (context, url) => const Center(
                                                  child: CircularProgressIndicator(),
                                                ),
                                                errorWidget: (context, url, error) => const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }else{
                                  return Container();
                                }
                              },
                            )*/
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    )
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: (){Navigator.pop(context);},
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres){
    String result = '';
    for (var genre in genres){
      result += genre.name + ', ';
    }
    if(result.isEmpty){
      return result;
    }
    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime){
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;
    if(hours > 0){
      return '${hours}h ${minutes}m';
    }else{
      return '${minutes}m';
    }
  }

}
