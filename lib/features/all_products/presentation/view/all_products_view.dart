import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:market_ease/core/data_source/remote/api_service.dart';
import 'package:market_ease/core/shared_models/filter_model.dart';
import 'package:market_ease/core/shared_widgets/no_products.dart';
import 'package:market_ease/core/shared_widgets/snack_bar.dart';
import 'package:market_ease/core/shared_widgets/transition_loading.dart';
import 'package:market_ease/features/all_products/data/repo/product_implementation.dart';
import 'package:market_ease/features/all_products/presentation/view/widgets/product_item.dart';
import 'package:market_ease/features/all_products/presentation/view_model/product_cubit.dart';
import 'package:market_ease/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:market_ease/features/cart/presentation/view_model/cart_state.dart';
import 'package:market_ease/features/wishlist/presentation/view_model/wishlist_cubit.dart';
import 'package:market_ease/features/wishlist/presentation/view_model/wishlist_state.dart';
import '../../../../core/routes/app_routes.dart';
import '../view_model/product_state.dart';

class AllProductsView extends StatelessWidget {
  const AllProductsView({super.key, required this.filteredProduct});

  final FilterModel filteredProduct;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductCubit(ProductImplementation(ApiService()), filteredProduct),
      child: MultiBlocListener(
        listeners: [
          BlocListener<CartCubit, CartState>(
            listener: (context, state) {
              if (state is AddToCartSuccess) {
                SnackBarCustom.showSuccessSnackBar(context, state.message);
              } else if (state is AddToCartFailure) {
                SnackBarCustom.showFailureSnackBar(context, state.errorMessage);
              }
            },
          ),
          BlocListener<WishlistCubit, WishlistState>(
            listener: (context, state) {
              if (state is AddToWishlistSuccess) {
                SnackBarCustom.showSuccessSnackBar(context, state.message);
                context.read<WishlistCubit>().getWishlist();
              } else if (state is AddToWishlistFailure) {
                SnackBarCustom.showFailureSnackBar(context, state.errorMessage);
              } else if (state is RemoveFromWishlistSuccess) {
                SnackBarCustom.showSuccessSnackBar(context, state.message);
                context.read<WishlistCubit>().getWishlist();
              } else if (state is RemoveFromWishlistFailure) {
                SnackBarCustom.showFailureSnackBar(context, state.errorMessage);
              }
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text(filteredProduct.title,style: Theme.of(context).textTheme.titleMedium,),
          ),
          body: BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is ProductSuccess) {
                return state.products.isEmpty
                    ? Center(child: NoProducts())
                    : Padding(
                        padding: const EdgeInsets.only(
                          top: 16,
                          left: 16,
                          right: 16,
                        ),
                        child: GridView.builder(
                          itemCount: state.products.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.6,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 15.h,
                              ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => context.push(
                                AppRoutes.kProductDetailsView,
                                extra: state.products[index],
                              ),
                              child: ProductItem(
                                productModel: state.products[index],
                              ),
                            );
                          },
                        ),
                      );
              } else if (state is ProductFailure) {
                return Center(child: Text(state.errorMessage));
              } else {
                return const Center(child: TransitionLoading());
              }
            },
          ),
        ),
      ),
    );
  }
}
