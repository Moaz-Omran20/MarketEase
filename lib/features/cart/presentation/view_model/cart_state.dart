import '../../data/model/cart_response_model.dart';

abstract class CartState {}

class CartLoading extends CartState {}
class CartInitial extends CartState {}

class CartSuccess extends CartState {
  final CartResponseModel cartResponse;
  CartSuccess(this.cartResponse);
}

class CartFailure extends CartState {
  final String errorMessage;
  CartFailure(this.errorMessage);
}

class AddToCartLoading extends CartState {
  final String productId;
  AddToCartLoading(this.productId);
}

class AddToCartSuccess extends CartState {
  final String message;
  AddToCartSuccess(this.message);
}

class AddToCartFailure extends CartState {
  final String errorMessage;
  AddToCartFailure(this.errorMessage);
}

class RemoveFromCartLoading extends CartState {
  final String productId;
  RemoveFromCartLoading(this.productId);
}

class RemoveFromCartSuccess extends CartState {
  final String message;
  RemoveFromCartSuccess(this.message);
}

class RemoveFromCartFailure extends CartState {
  final String errorMessage;
  RemoveFromCartFailure(this.errorMessage);
}

class UpdateCartQuantityLoading extends CartState {
  final String productId;
  UpdateCartQuantityLoading(this.productId);
}

class UpdateCartQuantitySuccess extends CartState {
  final String message;
  UpdateCartQuantitySuccess(this.message);
}

class UpdateCartQuantityFailure extends CartState {
  final String errorMessage;
  UpdateCartQuantityFailure(this.errorMessage);
}
