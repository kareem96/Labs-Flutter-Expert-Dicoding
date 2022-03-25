


import 'package:app_example_images_cat/presentation/notifier/cat_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<CatNotifier>(
          builder: (context, notifier, child){
            final catImage = notifier.image;
            return Center(
              child: catImage != null ? Image.network(catImage.link) : const Text('Image not loaded yet'),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh_outlined),
        onPressed: () async {
          Provider.of<CatNotifier>(context, listen: false).getCatImage();
        },
      ),
    );
  }
}
