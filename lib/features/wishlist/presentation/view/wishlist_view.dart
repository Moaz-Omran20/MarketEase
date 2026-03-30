import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:market_ease/core/routes/app_routes.dart';
import 'package:market_ease/core/shared_widgets/no_products.dart';
import 'package:market_ease/core/shared_widgets/snack_bar.dart';
import 'package:market_ease/core/shared_widgets/transition_loading.dart';
import 'package:market_ease/features/wishlist/presentation/view/widgets/wishlist_item.dart';
import 'package:market_ease/features/wishlist/presentation/view_model/wishlist_cubit.dart';
import 'package:market_ease/features/wishlist/presentation/view_model/wishlist_state.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<WishlistCubit, WishlistState>(
        listener: (context, state) {
          if (state is RemoveFromWishlistSuccess) {
            SnackBarCustom.showSuccessSnackBar(context, state.message);
            context.read<WishlistCubit>().getWishlist();
          } else if (state is RemoveFromWishlistFailure) {
            SnackBarCustom.showFailureSnackBar(context, state.errorMessage);
          }
        },
        child: BlocBuilder<WishlistCubit, WishlistState>(
          buildWhen: (previous, current) =>
              current is WishlistSuccess ||
              current is WishlistFailure ||
              current is WishlistLoading,
          builder: (context, state) {
            if (state is WishlistSuccess) {
              return state.wishlist.isEmpty
                  ? Center(child: NoProducts())
                  : Padding(
                      padding: const EdgeInsets.all(16),
                      child: ListView.separated(
                        itemCount: state.wishlist.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final item = state.wishlist[index];
                          return InkWell(
                            onTap: () {
                              context.push(
                                AppRoutes.kProductDetailsView,
                                extra: item,
                              );
                            },
                            child: WishlistItem(
                              item.imageCover ?? "",
                              item.title ?? "",
                              item.price?.toDouble() ?? 0.0,
                              () {
                                context
                                    .read<WishlistCubit>()
                                    .removeFromWishlist(item.id!);
                              },
                            ),
                          );
                        },
                      ),
                    );
            } else if (state is WishlistFailure) {
              return Center(child: Text(state.errorMessage));
            } else if (state is WishlistLoading) {
              return const Center(child: TransitionLoading());
            } else {
              return const Center(child: Text("Your wishlist is empty"));
            }
          },
        ),
      ),
    );
  }
}
