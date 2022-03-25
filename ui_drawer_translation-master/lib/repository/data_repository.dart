import 'package:ui_drawer_translation/data/data.dart';
import 'package:ui_drawer_translation/models/category.dart';

class DataRepository {
  List<Category> fetchData() {
    var data = MyData.data;
    var dataList = data.values.map((e) => Category.fromJson(e)).toList();
    return dataList;
  }
}
