import 'package:market_ease/core/shared_models/product_model.dart';

abstract class ProductState {}

class ProductLoading extends ProductState {}
class ProductSuccess extends ProductState {
  final List<ProductModel> products;
  ProductSuccess(this.products);
}
class ProductFailure extends ProductState {
  final String errorMessage;
  ProductFailure(this.errorMessage);
}