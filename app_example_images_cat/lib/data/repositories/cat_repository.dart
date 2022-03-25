


import 'dart:convert';

import 'package:app_example_images_cat/domain/cat_image.dart';
import 'package:http/http.dart' as http;


class CatRepository{
  final http.Client _client;

  CatRepository(this._client);

  Future<CatImage> getImage() async{
    final response = await _client.get(Uri.parse('https://some-random-api.ml/img/cat'));
    return CatImage.fromJson(jsonDecode(response.body));
  }
}