import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_ease/features/cart/data/repo/cart_product_repo.dart';
import 'package:market_ease/features/cart/presentation/view_model/cart_state.dart';

import '../../../../core/data_source/remote/errors/failures.dart';
import '../../data/model/cart_response_model.dart';

class CartCubit extends Cubit<CartState> {
  final CartProductRepo cartProductRepo;
  CartResponseModel? currentCart;

  CartCubit(this.cartProductRepo) : super(CartInitial()) {
    getCart();
  }

  Future<void> getCart() async {
    try {
      emit(CartLoading());
      final cartResponse = await cartProductRepo.getCartProducts();
      currentCart = cartResponse;
      emit(CartSuccess(cartResponse));
    } catch (e) {
      if (e is DioException) {
        emit(CartFailure(ServerFailure.fromDioException(e).errorMessage));
      } else {
        emit(CartFailure(e.toString()));
      }
    }
  }

  Future<void> addToCart(String productId) async {
    emit(AddToCartLoading(productId));
    try {
      final message = await cartProductRepo.addProductToCart(productId);
      emit(AddToCartSuccess(message));
      await getCart();
    } catch (e) {
      if (e is DioException) {
        emit(AddToCartFailure(ServerFailure.fromDioException(e).errorMessage));
      } else {
        emit(AddToCartFailure(e.toString()));
      }
    }
  }

  Future<void> removeFromCart(String productId) async {
    if (currentCart == null) return;
    final previousCart = currentCart!;
    final updatedProducts = currentCart!.products
        .where((product) => product.id != productId)
        .toList();

    int updatedPrice = 0;
    for (var p in updatedProducts) {
      updatedPrice += (p.price * p.count);
    }

    currentCart = CartResponseModel(
      products: updatedProducts,
      totalPrice: updatedPrice,
    );
    emit(CartSuccess(currentCart!));

    try {
      await cartProductRepo.removeProductFromCart(productId);
    } catch (e) {
      currentCart = previousCart;
      emit(CartSuccess(currentCart!));
      if (e is DioException) {
        emit(RemoveFromCartFailure(
            ServerFailure.fromDioException(e).errorMessage));
      } else {
        emit(RemoveFromCartFailure(e.toString()));
      }
    }
  }

  Future<void> updateQuantity(String productId, int newQuantity) async {
    if (newQuantity < 1) return;

    emit(UpdateCartQuantityLoading(productId));
    try {
      final cartResponse =
          await cartProductRepo.updateProductQuantity(productId, newQuantity);
      currentCart = cartResponse;
      emit(CartSuccess(cartResponse));
      emit(UpdateCartQuantitySuccess("Quantity updated successfully"));
    } catch (e) {
      if (e is DioException) {
        emit(UpdateCartQuantityFailure(
            ServerFailure.fromDioException(e).errorMessage));
      } else {
        emit(UpdateCartQuantityFailure(e.toString()));
      }
    }
  }
}
