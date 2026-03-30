import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_ease/core/shared_models/product_model.dart';
import 'package:market_ease/features/wishlist/data/wishlist_repo.dart';
import 'package:market_ease/features/wishlist/presentation/view_model/wishlist_state.dart';

import '../../../../core/data_source/remote/errors/failures.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final WishlistRepo wishlistRepo;

  WishlistCubit(this.wishlistRepo) : super(WishlistInitial()) {
    getWishlist();
  }

  List<ProductModel>? currentWishlist;

  Future<void> getWishlist() async {
    emit(WishlistLoading());
    try {
      final wishlist = await wishlistRepo.getWishlistProducts();
      currentWishlist = wishlist;
      emit(WishlistSuccess(wishlist));
    } catch (e) {
      if (e is DioException) {
        emit(WishlistFailure(ServerFailure.fromDioException(e).errorMessage));
      } else {
        emit(WishlistFailure(e.toString()));
      }
    }
  }

  Future<void> addToWishlist(String productId) async {
    if (currentWishlist == null) return;

    // 1. Save original state for rollback
    final previousWishlist = List<ProductModel>.from(currentWishlist!);

    // 2. Optimistic Update: Add placeholder to local list immediately
    currentWishlist!.add(ProductModel(id: productId));
    emit(WishlistSuccess(currentWishlist!));

    try {
      final message = await wishlistRepo.addProductToWishlist(productId);
      emit(AddToWishlistSuccess(message));
      // Sync with server to get the full product details (images, title, etc.)
      await getWishlist();
    } catch (e) {
      // Rollback on failure
      currentWishlist = previousWishlist;
      emit(WishlistSuccess(currentWishlist!));

      if (e is DioException) {
        emit(AddToWishlistFailure(
          ServerFailure.fromDioException(e).errorMessage,
        ));
      } else {
        emit(AddToWishlistFailure(e.toString()));
      }
    }
  }

  Future<void> removeFromWishlist(String productId) async {
    if (currentWishlist == null) return;

    // 1. Save original state for rollback
    final previousWishlist = List<ProductModel>.from(currentWishlist!);

    // 2. Optimistic Update: Remove from local list immediately
    currentWishlist!.removeWhere((item) => item.id == productId);
    emit(WishlistSuccess(currentWishlist!));

    try {
      final message = await wishlistRepo.removeProductFromWishlist(productId);
      emit(RemoveFromWishlistSuccess(message));
    } catch (e) {
      // Rollback on failure
      currentWishlist = previousWishlist;
      emit(WishlistSuccess(currentWishlist!));

      if (e is DioException) {
        emit(RemoveFromWishlistFailure(
          ServerFailure.fromDioException(e).errorMessage,
        ));
      } else {
        emit(RemoveFromWishlistFailure(e.toString()));
      }
    }
  }
}
