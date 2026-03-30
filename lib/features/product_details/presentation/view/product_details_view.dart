import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_ease/core/shared_models/product_model.dart';
import 'package:market_ease/core/shared_widgets/product_loading.dart';
import 'package:market_ease/core/shared_widgets/snack_bar.dart';
import 'package:market_ease/features/cart/presentation/view_model/cart_state.dart';
import '../../../cart/presentation/view_model/cart_cubit.dart';
import '../../../onboarding/widgets/onboarding_indicators.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is AddToCartSuccess) {
          SnackBarCustom.showSuccessSnackBar(context, state.message);
        } else if (state is AddToCartFailure) {
          SnackBarCustom.showFailureSnackBar(context, state.errorMessage);
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 450.h,
                width: double.infinity,
                child: PageView.builder(
                  onPageChanged: (value) {
                    currentIndex = value;
                    setState(() {});
                  },
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>  Center(
                        child: SizedBox(
                          height: 100.h,
                          width: 100.w,
                          child: ProductLoading(),
                        ),
                      ),
                      imageUrl: widget.product.fullImages[index],
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error, color: Colors.red),
                    );
                  },
                  itemCount: widget.product.images?.length ?? 0,
                ),
              ),
              const SizedBox(height: 8),
              OnboardingIndicators(
                currentIndex: currentIndex,
                listLength: widget.product.images?.length ?? 0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      widget.product.title ?? "",
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium!.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.product.category!.name!,
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall!.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          '${widget.product.price} EGP',
                          style: Theme.of(context).textTheme.displayLarge!
                              .copyWith(color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                        widget.product.priceAfterDiscount == null
                            ? const SizedBox()
                            : Text(
                                '${widget.product.priceAfterDiscount ?? ""} EGP',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade400,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.grey.shade400,
                                ),
                              ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: BoxBorder.all(color: Colors.white),
                            borderRadius: BorderRadiusGeometry.circular(12),
                          ),
                          child: Text(
                            "Sold  ${widget.product.sold.toString()}",
                            style: Theme.of(context).textTheme.titleSmall!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Text("in stock", style: TextStyle(color: Colors.green)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellowAccent),
                        Text(widget.product.ratingsAverage.toString()),
                        const SizedBox(width: 6),
                        Text("(${widget.product.ratingsQuantity})"),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: BoxBorder.all(color: Colors.white),
                            borderRadius: BorderRadiusGeometry.circular(12),
                          ),
                          child: Text(
                            "quantity  ${widget.product.quantity.toString()}",
                            style: Theme.of(context).textTheme.titleSmall!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Description",
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium!.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.product.description.toString(),
                      style: Theme.of(
                        context,
                      ).textTheme.displaySmall!.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      height: 45.h,
                      child: BlocBuilder<CartCubit, CartState>(
                        builder: (context, state) {
                          return state is AddToCartLoading
                              ? Center(child: ProductLoading())
                              : ElevatedButton(
                                  onPressed: () {
                                    context.read<CartCubit>().addToCart(
                                      widget.product.id!,
                                    );
                                  },
                                  child: state is AddToCartLoading
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.shopping_cart),
                                            SizedBox(width: 10),
                                            Text("Add to cart"),
                                          ],
                                        ),
                                );
                        },
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
