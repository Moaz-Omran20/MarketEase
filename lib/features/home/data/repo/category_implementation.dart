import 'package:market_ease/core/data_source/remote/api_service.dart';
import 'package:market_ease/features/home/data/models/category_model.dart';
import 'package:market_ease/features/home/data/repo/category_repo.dart';

import '../../../../core/data_source/remote/api_config.dart';

class CategoryImplementation extends CategoryRepo {
  ApiService apiService;

  CategoryImplementation(this.apiService);

  @override
  Future<List<CategoryModel>> getCategories() async {
    // TODO: implement getCategories
    try {
      final response = await apiService.get(endPoint: ApiEndPoints.categories);
      List<CategoryModel> categories = [];
      for (var item in response.data["data"]) {
        categories.add(CategoryModel.fromJson(item));
      }
      return categories;
    } catch (e) {
      throw e.toString();
    }
  }
}
