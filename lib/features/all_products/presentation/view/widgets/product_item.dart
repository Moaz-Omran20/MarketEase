import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_ease/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:market_ease/features/cart/presentation/view_model/cart_state.dart';
import 'package:market_ease/features/wishlist/presentation/view_model/wishlist_cubit.dart';
import 'package:market_ease/features/wishlist/presentation/view_model/wishlist_state.dart';

import '../../../../../core/shared_models/product_model.dart';
import '../../../../../core/shared_widgets/product_loading.dart';
import '../../../../../core/theme/light_colors.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF140D2B),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -----------── Image Section ──────────────────
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child:
                      widget.productModel.imageCover != null &&
                          widget.productModel.imageCover!.isNotEmpty
                      ? CachedNetworkImage(
                          height: 140.h,
                          imageUrl: widget.productModel.imageCover!,
                          fit: BoxFit.fill,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          placeholder: (context, url) =>  Center(
                            child: SizedBox(
                              height: 50.h,
                              width: 50.w,
                              child: ProductLoading(),
                            ),
                          ),
                        )
                      : Container(
                          height: 140.h,
                          color: Colors.grey[800],
                          child: const Icon(
                            Icons.image_not_supported,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
              // Wishlist button
              Positioned(
                top: 8,
                right: 8,
                child: BlocBuilder<WishlistCubit, WishlistState>(
                  builder: (context, state) {
                    final cubit = context.read<WishlistCubit>();
                    final bool isWishlisted =
                        cubit.currentWishlist?.any(
                          (e) => e.id == widget.productModel.id,
                        ) ??
                        false;

                    return Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {
                          if (isWishlisted) {
                            cubit.removeFromWishlist(widget.productModel.id!);
                          } else {
                            cubit.addToWishlist(widget.productModel.id!);
                          }
                        },
                        icon: Icon(
                          isWishlisted ? Icons.favorite : Icons.favorite_border,
                          size: 16,
                          color: isWishlisted
                              ? Colors.redAccent
                              : Colors.grey.shade400,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          // ── Info Section ───────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product name
                Text(
                  widget.productModel.title ?? "",
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),

                // Product subtitle
                Text(
                  widget.productModel.description ?? "",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                    height: 1.3,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                // Price row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.productModel.price} EGP',
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall!.copyWith(color: Colors.white),
                    ),
                    const SizedBox(width: 6),
                    widget.productModel.priceAfterDiscount == null
                        ? const SizedBox()
                        : Text(
                            '${widget.productModel.priceAfterDiscount ?? ""} EGP',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade400,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.grey.shade400,
                            ),
                          ),
                  ],
                ),
                const SizedBox(height: 8),

                // Review row + Add button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Rating
                    Row(
                      children: [
                        Text(
                          'Reviews ',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Text(
                          '(${widget.productModel.ratingsQuantity})',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(width: 3),
                        const Icon(
                          Icons.star_rounded,
                          size: 14,
                          color: Color(0xFFFFC107),
                        ),
                      ],
                    ),

                    // Add to cart button
                    BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        final isLoading =
                            state is AddToCartLoading &&
                            state.productId == widget.productModel.id;
                        return isLoading
                            ? SizedBox(
                                height: 28.h,
                                width: 28.w,
                                child: ProductLoading(),
                              )
                            : GestureDetector(
                                onTap: () {
                                  context.read<CartCubit>().addToCart(
                                    widget.productModel.id!,
                                  );
                                },
                                child: Container(
                                  width: 28.w,
                                  height: 28.h,
                                  decoration: const BoxDecoration(
                                    color: LightColors.primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
