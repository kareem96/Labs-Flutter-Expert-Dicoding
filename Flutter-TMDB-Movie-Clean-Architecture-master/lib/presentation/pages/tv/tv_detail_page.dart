


import 'package:app_clean_architecture_flutter/data/model/genre_model.dart';
import 'package:app_clean_architecture_flutter/domain/entities/tv/tv.dart';
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
      Provider.of<TvDetailNotifier>(context, listen: false).loadWatchlistStatusTv(widget.id);

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
                provider.isAddedToWatchListTv,
                provider.tvRecommendation,
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
  final bool isAddedWatchlistTv;
  final List<Tv> recommendation;
  ContentDetails(this.tvDetail, this.isAddedWatchlistTv, this.recommendation);

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
                            ElevatedButton(
                                onPressed: ()async{
                                  if(!isAddedWatchlistTv){
                                    await Provider.of<TvDetailNotifier>(context, listen: false).addWatchlist(tvDetail);
                                  }else{
                                    await Provider.of<TvDetailNotifier>(context, listen: false).removeFromWatchlistTv(tvDetail);
                                  }
                                  final message = Provider.of<TvDetailNotifier>(context, listen: false).watchlistMessageTv;
                                  if(message == TvDetailNotifier.watchlistAddSuccessMessage || message == TvDetailNotifier.watchlistRemoveSuccessMessage){
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), duration: const Duration(milliseconds: 300),));
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
                                    isAddedWatchlistTv ? const Icon(Icons.check) : const Icon(Icons.add),
                                    const Text('Watchlist')
                                  ],
                                )
                            ),
                            Text(_showGenres(tvDetail.genres)),
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
                            Text('Seasons', style: Heading6,),
                            _buildSeason(context, tvDetail.seasons),
                            Text('Recommendations', style: Heading6,),
                            Consumer<TvDetailNotifier>(
                              builder: (context, data, child){
                                if(data.tvRecommendationState == RequestState.Loading){
                                  return const Center(child: CircularProgressIndicator(),);
                                }else if(data.tvRecommendationState == RequestState.Error){
                                  return Text(data.message);
                                }else if(data.tvRecommendationState == RequestState.Loaded){
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: recommendation.length,
                                      itemBuilder: (context, index){
                                        final movie = recommendation[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: InkWell(
                                            onTap: (){
                                              Navigator.pushReplacementNamed(context, TvDetailPage.routeName, arguments: movie.id);
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
                            )
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


  Widget _buildSeason(BuildContext context, List<Season> season){
    return Column(
      children: [
        const SizedBox(height: 8,),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
              itemCount: season.length,
              itemBuilder: (context, index){
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(season[index].name)
                      ],
                    ),
                  ),
                );
              }
          ),
        )
      ],
    );
  }

  String _showGenres(List<GenreModel> genres){
    String result = '';
    for (var genre in genres){
      result += genre.name + ', ';
    }
    if(result.isEmpty){
      return result;
    }
    return result.substring(0, result.length - 2);
  }

}
