import 'package:market_ease/core/data_source/remote/api_service.dart';
import 'package:market_ease/core/shared_models/product_model.dart';
import 'package:market_ease/features/wishlist/data/wishlist_repo.dart';

import '../../../core/data_source/remote/api_config.dart';
import '../../../core/services/secure_storage.dart';
import '../../../core/utils/app_constants.dart';

class WishlistImplementation extends WishlistRepo {
  WishlistImplementation(this.apiService);

  ApiService apiService;

  @override
  Future<List<ProductModel>> getWishlistProducts() async {
    final token = await SecureStorage.get(key: AppConstants.tokenKey);
    final response = await apiService.get(
      token: token,
      endPoint: ApiEndPoints.wishList,
    );
    final List<ProductModel> wishlistProducts = [];
    for (var product in response.data["data"]) {
      wishlistProducts.add(ProductModel.fromJson(product));
    }
    return wishlistProducts;
  }

  @override
  Future<String> addProductToWishlist(String productId) async {
    final token = await SecureStorage.get(key: AppConstants.tokenKey);
    final response = await apiService.post(
      endPoint: ApiEndPoints.wishList,
      data: {"productId": productId},
      token: token,
    );
    return response.data["message"];
  }

  @override
  Future<String> removeProductFromWishlist(String productId) async {
    final token = await SecureStorage.get(key: AppConstants.tokenKey);
    final response = await apiService.delete(
      endPoint: "${ApiEndPoints.wishList}/$productId",
      token: token,
    );
    return response.data["message"];
  }
}
