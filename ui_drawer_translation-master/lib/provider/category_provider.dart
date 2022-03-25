import 'package:ui_drawer_translation/models/category.dart';
import 'package:ui_drawer_translation/repository/data_repository.dart';

class CategoryProvider {
  List<Category> _categories = [];
  List<Category> get getCategories => _categories;

  fetchData() {
    var dataRepo = DataRepository();
    var categories = dataRepo.fetchData();
    _categories = categories;
  }
}
