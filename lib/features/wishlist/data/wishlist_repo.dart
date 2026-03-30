import 'package:market_ease/core/shared_models/product_model.dart';

abstract class WishlistRepo {
  Future<List<ProductModel>> getWishlistProducts();
  Future<String> addProductToWishlist(String productId);
  Future<String> removeProductFromWishlist(String productId);
}
