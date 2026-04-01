import '../model/cart_response_model.dart';

abstract class CartProductRepo {
  Future<CartResponseModel> getCartProducts();

  Future<String> addProductToCart(String productId);
  Future<String> removeProductFromCart(String productId);
  Future<String> clearCart();
  Future<CartResponseModel> updateProductQuantity(String productId, int quantity);
}
