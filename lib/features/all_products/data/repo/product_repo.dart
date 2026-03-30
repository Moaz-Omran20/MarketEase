import 'package:market_ease/core/shared_models/product_model.dart';

import '../../../../core/shared_models/filter_model.dart';

abstract class ProductRepo {
  Future<List<ProductModel>> products(FilterModel filteredProduct);
}
