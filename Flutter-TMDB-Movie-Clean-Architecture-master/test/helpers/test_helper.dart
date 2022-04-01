

import 'package:app_clean_architecture_flutter/common/network_info.dart';
import 'package:app_clean_architecture_flutter/data/datasources/db/database_helper.dart';
import 'package:app_clean_architecture_flutter/data/datasources/db/database_helper_tv.dart';
import 'package:app_clean_architecture_flutter/data/datasources/local/local_data_source.dart';
import 'package:app_clean_architecture_flutter/data/datasources/local/tv/local_data_source_tv.dart';
import 'package:app_clean_architecture_flutter/data/datasources/remote/remote_data_source.dart';
import 'package:app_clean_architecture_flutter/domain/repositories/movie_respository.dart';
import 'package:app_clean_architecture_flutter/domain/repositories/tv_repository.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks([
  MovieRepository,
  TvRepository,
  MovieRemoteDataSource,
  TvLocalDataSource,
  MovieLocalDataSource,
  DatabaseHelperTv,
  DatabaseHelper,
  NetworkInfo,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])


void main(){

}
