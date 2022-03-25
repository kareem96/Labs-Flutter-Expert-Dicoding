



import 'package:app_example_images_cat/data/repositories/cat_repository.dart';
import 'package:app_example_images_cat/domain/cat_image.dart';
import 'package:flutter/cupertino.dart';

class CatNotifier extends ChangeNotifier{
  CatImage? _image;
  CatImage? get image => _image;

  final CatRepository _repository;

  CatNotifier(this._repository);

  void getCatImage() async{
    _image = await _repository.getImage();
    notifyListeners();
  }
}