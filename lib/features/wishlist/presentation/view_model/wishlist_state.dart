import 'package:market_ease/core/shared_models/product_model.dart';

abstract class WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistSuccess extends WishlistState {
  final List<ProductModel> wishlist;
  WishlistSuccess(this.wishlist);
}

class WishlistFailure extends WishlistState {
  final String errorMessage;
  WishlistFailure(this.errorMessage);
}

class AddToWishlistLoading extends WishlistState {
  final String productId;
  AddToWishlistLoading(this.productId);
}

class AddToWishlistSuccess extends WishlistState {
  final String message;
  AddToWishlistSuccess(this.message);
}

class AddToWishlistFailure extends WishlistState {
  final String errorMessage;
  AddToWishlistFailure(this.errorMessage);
}

class RemoveFromWishlistLoading extends WishlistState {
  final String productId;
  RemoveFromWishlistLoading(this.productId);
}

class RemoveFromWishlistSuccess extends WishlistState {
  final String message;
  RemoveFromWishlistSuccess(this.message);
}

class RemoveFromWishlistFailure extends WishlistState {
  final String errorMessage;
  RemoveFromWishlistFailure(this.errorMessage);
}
