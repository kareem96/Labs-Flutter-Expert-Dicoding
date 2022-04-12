


import 'package:core/utils/state_enum.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/tv/watchlist_tv_notifier.dart';
import '../../widgets/card_tv_list.dart';

class WatchlistTvPage extends StatefulWidget {
  static const routeName = '/watchlist_tv_page';
  const WatchlistTvPage({Key? key}) : super(key: key);

  @override
  State<WatchlistTvPage> createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => Provider.of<WatchlistTvNotifier>(context, listen: false).fetchWatchlistTv());
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    // TODO: implement didPopNext
    super.didPopNext();
    Provider.of<WatchlistTvNotifier>(context, listen: false).fetchWatchlistTv();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    routeObserver.unsubscribe(this);

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Consumer<WatchlistTvNotifier>(
        builder: (context, data, child){
          if(data.watchlistStateTv == RequestState.Loading){
            return const Center(child: CircularProgressIndicator(),);
          }else if(data.watchlistStateTv == RequestState.Loaded){
            return ListView.builder(
              itemCount: data.watchlistTv.length,
              itemBuilder: (context, index){
                final movie = data.watchlistTv[index];
                return CardTvList(movie);
              },
            );
          }else{
            return Center(
              key: const Key('error_message'),
              child: Text(data.message),
            );
          }
        },
      ),
    );
  }
}
