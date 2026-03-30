import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_ease/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:market_ease/features/cart/presentation/view_model/cart_state.dart';

import '../../../../../core/shared_widgets/product_loading.dart';
import '../../../../../core/theme/light_colors.dart';

class ProductCartItem extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final double price;
  final int count;
  final String productId;
  final VoidCallback? onDelete;
  final VoidCallback? decrement;
  final VoidCallback? increment;

  const ProductCartItem({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.price,
    required this.count,
    required this.productId,
    this.onDelete,
    this.decrement,
    this.increment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF140D2B),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Product Image
          Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 100.w,
                  height: 100.h,
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  placeholder: (context, url) =>
                      const Center(child: ProductLoading()),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 30.h,
                decoration: BoxDecoration(
                  color: LightColors.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                  shape: BoxShape.rectangle,
                ),
                child: BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    final isLoading =
                        state is UpdateCartQuantityLoading &&
                        state.productId == productId;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: count > 1 ? decrement : null,
                          icon: const Icon(Icons.remove, size: 20),
                          color: Colors.white,
                        ),
                        isLoading
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: ProductLoading(),
                              )
                            : Text(
                                count.toString(),
                                style: Theme.of(context).textTheme.titleSmall!
                                    .copyWith(color: Colors.white),
                              ),
                        IconButton(
                          onPressed: increment,
                          icon: const Icon(Icons.add, size: 20),
                          color: Colors.white,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),

          const SizedBox(width: 16),

          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${price.toStringAsFixed(2)} EGP',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          // Delete Button
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: onDelete,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.red.shade400,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
