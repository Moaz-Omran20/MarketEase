import 'package:market_ease/core/data_source/remote/api_config.dart';
import 'package:market_ease/core/data_source/remote/api_service.dart';
import 'package:market_ease/core/shared_models/product_model.dart';
import 'package:market_ease/features/all_products/data/repo/product_repo.dart';

import '../../../../core/shared_models/filter_model.dart';

class ProductImplementation implements ProductRepo {
  final ApiService apiService;

  ProductImplementation(this.apiService);

  @override
  Future<List<ProductModel>> products(FilterModel filteredProduct) async {
    final response = await apiService.get(
      endPoint: ApiEndPoints.products,
      queryParameters: {filteredProduct.filterType: filteredProduct.productId},
    );

    final List<dynamic> data = response.data['data'];
    return data.map((json) => ProductModel.fromJson(json)).toList();
  }
}
