import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../checkout/data/repo/checkout_repo_implementation.dart';
import '../../../../checkout/presentation/view/payment_methods_bottom_sheet.dart';
import '../../../../checkout/presentation/view_model/payment_cubit.dart';

class CartPriceAndCheckoutSection extends StatelessWidget {
  const CartPriceAndCheckoutSection({super.key, required this.totalPrice});

  final int totalPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total Price",
              style: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(color: Colors.white),
            ),
            Text(
              "$totalPrice EGP",
              style: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(color: Colors.green),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 42.h,
          child: ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return BlocProvider(
                    create: (context) =>
                        PaymentCubit(CheckoutRepoImplementation()),
                    child: PaymentMethodsBottomSheet(price: totalPrice,),
                  );
                },
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart),
                SizedBox(width: 8),
                Text("Checkout"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
