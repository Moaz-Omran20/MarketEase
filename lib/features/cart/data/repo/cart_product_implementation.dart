import 'package:market_ease/core/data_source/remote/api_service.dart';
import 'package:market_ease/core/utils/app_constants.dart';
import '../../../../core/data_source/remote/api_config.dart';
import '../../../../core/services/secure_storage.dart';
import '../model/cart_response_model.dart';
import 'cart_product_repo.dart';

class CartProductImplementation extends CartProductRepo {
  CartProductImplementation(this.apiService);

  ApiService apiService;

  @override
  Future<CartResponseModel> getCartProducts() async {
    final token = await SecureStorage.get(key: AppConstants.tokenKey);
    final response = await apiService.get(
      endPoint: ApiEndPoints.cart,
      token: token,
    );

    return CartResponseModel.fromJson(response.data);
  }

  @override
  Future<String> addProductToCart(String productId) async {
    final token = await SecureStorage.get(key: AppConstants.tokenKey);
    final response = await apiService.post(
      endPoint: ApiEndPoints.cart,
      data: {"productId": productId},
      token: token,
    );
    return response.data["message"];
  }

  @override
  Future<String> removeProductFromCart(String productId) async {
    final token = await SecureStorage.get(key: AppConstants.tokenKey);
    final response = await apiService.delete(
      endPoint: "${ApiEndPoints.cart}/$productId",
      token: token,
    );
    return response.data["status"];
  }

  @override
  Future<CartResponseModel> updateProductQuantity(String productId, int quantity) async {
    final token = await SecureStorage.get(key: AppConstants.tokenKey);
    final response = await apiService.put(
      endPoint: "${ApiEndPoints.cart}/$productId",
      data: {"count": quantity}, // FIXED: API expects "count"
      token: token,
    );
    return CartResponseModel.fromJson(response.data);
  }

  @override
  Future<String> clearCart() async{
    final token = await SecureStorage.get(key: AppConstants.tokenKey);
    final response = await apiService.delete(
      endPoint: ApiEndPoints.cart,
      token: token,
    );
    return response.data["message"];
  }
}
