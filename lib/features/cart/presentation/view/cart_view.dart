import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:market_ease/core/shared_widgets/custom_alert_dialog.dart';
import 'package:market_ease/features/cart/presentation/view/widgets/cart_empty_widget.dart';
import 'package:market_ease/features/cart/presentation/view/widgets/cart_price_and_checkout_section.dart';
import 'package:market_ease/features/cart/presentation/view/widgets/product_cart_item.dart';
import 'package:market_ease/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:market_ease/features/cart/presentation/view_model/cart_state.dart';
import '../../../../core/shared_widgets/snack_bar.dart';
import '../../../../core/shared_widgets/transition_loading.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state is RemoveFromCartSuccess) {
            SnackBarCustom.showSuccessSnackBar(
              context,
              "Item removed Successfully",
            );
          } else if (state is RemoveFromCartFailure) {
            SnackBarCustom.showFailureSnackBar(context, state.errorMessage);
          }
        },
        child: BlocBuilder<CartCubit, CartState>(
          buildWhen: (previous, current) =>
              current is CartSuccess ||
              current is CartFailure ||
              current is CartLoading,
          builder: (context, state) {
            if (state is CartSuccess) {
              return state.cartResponse.products.isEmpty
                  ? CartEmptyWidget()
                  : Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.cartResponse.products.length,
                              itemBuilder: (context, index) {
                                final product =
                                    state.cartResponse.products[index];
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: ProductCartItem(
                                    imageUrl: product.image,
                                    onDelete: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) {
                                          return CustomAlertDialog(
                                            alertMessage:
                                                "Are you sure you want to remove this product from your cart ?",
                                            onNoPressed: () {
                                              context.pop();
                                            },
                                            onYesPressed: () {
                                              context
                                                  .read<CartCubit>()
                                                  .removeFromCart(product.id);
                                              context.pop();
                                            },
                                          );
                                        },
                                      );
                                    },
                                    productName: product.title,
                                    count: product.count,
                                    price: product.price.toDouble(),
                                    decrement: () {
                                      context.read<CartCubit>().updateQuantity(
                                        product.id,
                                        product.count - 1,
                                      );
                                    },
                                    increment: () {
                                      context.read<CartCubit>().updateQuantity(
                                        product.id,
                                        product.count + 1,
                                      );
                                    },
                                    productId: product.id,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          state.cartResponse.products.isEmpty
                              ? SizedBox()
                              : CartPriceAndCheckoutSection(
                                  totalPrice: state.cartResponse.totalPrice,
                                ),
                        ],
                      ),
                    );
            } else if (state is CartFailure) {
              return Center(child: Text(state.errorMessage));
            } else {
              return const Center(child: TransitionLoading());
            }
          },
        ),
      ),
    );
  }
}
