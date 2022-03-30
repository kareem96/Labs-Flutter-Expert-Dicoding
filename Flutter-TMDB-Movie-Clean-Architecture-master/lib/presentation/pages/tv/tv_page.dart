
import 'package:app_clean_architecture_flutter/presentation/pages/movies/home_page.dart';
import 'package:app_clean_architecture_flutter/presentation/pages/tv/tv_detail_page.dart';
import 'package:app_clean_architecture_flutter/presentation/pages/tv/tv_on_the_air_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/constant.dart';
import '../../../common/state_enum.dart';
import '../../../domain/entities/tv/tv.dart';
import '../../provider/tv/tv_list_notifier.dart';
import '../about_page.dart';
import '../search_page.dart';
import '../watchlist_page.dart';

class TvPage extends StatefulWidget {
  static const routeName = '/tv_home';
  const TvPage({Key? key}) : super(key: key);

  @override
  _TvPageState createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<TvListNotifier>(context, listen: false)
      ..fetchAiringTodayTv()
      ..fetchOnTheAirTv()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children:  [
            const UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/ui.png'),
                ),
                accountName: Text('Nonton Kuy'),
                accountEmail: Text('')
            ),
            ListTile(
              leading: const Icon(Icons.movie_outlined),
              title: const Text('Movies'),
              onTap: () => {
                // Navigator.pop(context)
                Navigator.pushNamed(context, HomePage.routeName)
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv_outlined),
              title: const Text('TV'),
              onTap: () => {Navigator.pop(context)},
            ),
            ListTile(
              leading: const Icon(Icons.save_alt_outlined),
              title: const Text('Watchlist'),
              onTap: (){
                Navigator.pushNamed(context, WatchlistPage.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outlined),
              title: const Text('About'),
              onTap: (){
                Navigator.pushNamed(context, AboutPage.routeName);
              },
            )
          ],
        ),
      ),
      appBar: AppBar(title: const Text('Nonton Kuy'),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.pushNamed(context, SearchPage.routeName);
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tv Airing Today', style: Heading6,),
              Consumer<TvListNotifier>(builder: (context, data, child) {
                final state = data.airingTodayState;
                if (state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TvList(data.airingTodayTv);
                } else {
                  return Text(data.message);
                }
              }),
              _buildSubHeading(
                  title: 'Tv On The Air',
                  onTap: () {
                    Navigator.pushNamed(context, TvOnTheAirPage.routeName);
                  }
              ),
              Consumer<TvListNotifier>(
                builder: (context, data, child){
                  final state = data.onTheAirTvState;
                  if(state == RequestState.Loading){
                    return const Center(child: CircularProgressIndicator(),);
                  }else if(state == RequestState.Loaded){
                    return TvList(data.onTheAirTv);
                  }else{
                    return Text(data.message);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Heading6,),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: const [
                Text('See more'),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        )
      ],
    );
  }

}

class TvList extends StatelessWidget {
  final List<Tv> tv;

  TvList(this.tv);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tv.length,
        itemBuilder: (context, index){
          final movieTv = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: (){
                debugPrint('${movieTv.id}');
                Navigator.pushNamed(context, TvDetailPage.routeName, arguments: movieTv.id);
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movieTv.posterPath}',
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
  }
}