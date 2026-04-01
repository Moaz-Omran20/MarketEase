import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:go_router/go_router.dart';
import 'package:market_ease/core/routes/app_routes.dart';
import 'package:market_ease/core/shared_widgets/product_loading.dart';
import 'package:market_ease/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:market_ease/features/checkout/presentation/view/widgets/custom_payment_button.dart';
import 'package:market_ease/features/checkout/presentation/view/widgets/payment_methods_list_view.dart';

import '../../../../core/shared_models/payment_models/payment_intent_input_model.dart';
import '../../../../core/utils/api_keys.dart';
import '../view_model/payment_cubit.dart';

class PaymentMethodsBottomSheet extends StatefulWidget {
  const PaymentMethodsBottomSheet({super.key, required this.price});

  final int price;

  @override
  State<PaymentMethodsBottomSheet> createState() =>
      _PaymentMethodsBottomSheetState();
}

class _PaymentMethodsBottomSheetState extends State<PaymentMethodsBottomSheet> {
  int selectedPaymentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                "Select Payment method : ",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: PaymentMethodsListView(
                  onChanged: (value) {
                    selectedPaymentIndex = value;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 35),
          BlocConsumer<PaymentCubit, PaymentState>(
            listener: (context, state) {
              if (state is PaymentSuccess) {
                context.read<CartCubit>().clearCart();
                context.pushReplacement(AppRoutes.kThankYouView);
              }
              if (state is PaymentFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Payment has been failed")));
              }
            },
            builder: (context, state) {
              if (state is PaymentLoading) {
                return SizedBox(height: 50, width: 50, child: ProductLoading());
              } else {
                return CustomPaymentButton(
                  title: "Continue",
                  onTap: () {
                    selectedPaymentIndex == 0
                        ? context.read<PaymentCubit>().makePayment(
                            paymentIntentInputModel: PaymentIntentInputModel(
                              amount: "${widget.price}00",
                              currency: "egp",
                              // customerId: "cus_TmL4M1Q4i64922",
                            ),
                          )
                        : Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => PaypalCheckoutView(
                                sandboxMode: true,
                                clientId: ApiKeys.paypalClientId,
                                secretKey: ApiKeys.paypalSecretKey,
                                transactions: [
                                  {
                                    "amount": {
                                      "total": widget.price.toString(),
                                      "currency": "USD",
                                      "details": {
                                        "subtotal": widget.price.toString(),
                                        "shipping": '0',
                                        "shipping_discount": 0,
                                      },
                                    },
                                    "description":
                                        "The payment transaction description.",
                                    "item_list": {
                                      "items": [
                                        {
                                          "name": "Cart Total",
                                          "quantity": 1,
                                          "price": widget.price.toString(),
                                          "currency": "USD",
                                        },
                                      ],
                                    },
                                  },
                                ],
                                note:
                                    "Contact us for any questions on your order.",
                                onSuccess: (Map params) async {
                                  context.read<CartCubit>().clearCart();
                                  context.pushReplacement(AppRoutes.kThankYouView);
                                },
                                onError: (error) {
                                  Navigator.pop(context);
                                },
                                onCancel: () {
                                },
                              ),
                            ),
                          );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
