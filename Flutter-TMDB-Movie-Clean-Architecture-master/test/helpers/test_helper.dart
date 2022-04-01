

import 'package:app_clean_architecture_flutter/common/network_info.dart';
import 'package:app_clean_architecture_flutter/data/datasources/db/database_helper.dart';
import 'package:app_clean_architecture_flutter/data/datasources/local/local_data_source.dart';
import 'package:app_clean_architecture_flutter/data/datasources/remote/remote_data_source.dart';
import 'package:app_clean_architecture_flutter/domain/repositories/movie_respository.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
  NetworkInfo,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])


void main(){

}
