import 'package:app_example_images_cat/presentation/notifier/cat_notifier.dart';
import 'package:app_example_images_cat/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'locator.dart' as di;

import 'package:http/http.dart';
import 'data/repositories/cat_repository.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      ///not locator
        /*create: (context) => CatNotifier(
          CatRepository(Client()),
        ),*/

      ///use locator
      create: (context) => di.locator<CatNotifier>(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
