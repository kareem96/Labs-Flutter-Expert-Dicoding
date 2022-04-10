

import 'package:app_clean_architecture_flutter/presentation/provider/tv/tv_on_the_air_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/state_enum.dart';
import '../../widgets/card_tv_list.dart';

class TvOnTheAirPage extends StatefulWidget {
  static const routeName = '/tv_on_the_air_page';

  const TvOnTheAirPage({Key? key}) : super(key: key);

  @override
  _TvOnTheAirPageState createState() => _TvOnTheAirPageState();
}

class _TvOnTheAirPageState extends State<TvOnTheAirPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() =>
        Provider.of<TvOnTheAirNotifier>(context, listen: false).fetchTvOnTheAir());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TV On The Air'),),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Consumer<TvOnTheAirNotifier>(
          builder: (context, provider, child) {
            if (provider.state == RequestState.Loading) {
              return const Center(child: CircularProgressIndicator(),);
            } else if (provider.state == RequestState.Loaded) {
              print('Berhasil');
              return ListView.builder(
                  itemCount:provider.tv.length,
                  itemBuilder: (context, index){
                    final movie = provider.tv[index];
                    return CardTvList(movie);
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
