import 'package:flutter/material.dart';
import 'package:market_ease/features/checkout/presentation/view/widgets/payment_method_list.dart';
import '../../../../../core/shared_models/payment_models/payment_method_model.dart';
import '../../../../../generated/assets.dart';

class PaymentMethodsListView extends StatefulWidget {


  final ValueChanged<int> onChanged;

  const PaymentMethodsListView({
    super.key,
    required this.onChanged,
  });


  @override
  State<PaymentMethodsListView> createState() => _PaymentMethodsListViewState();
}

class _PaymentMethodsListViewState extends State<PaymentMethodsListView> {
  final List<PaymentMethodModel> images = [
    PaymentMethodModel(image: Assets.imagesCreditCard),
    PaymentMethodModel(image: Assets.imagesPaypal),
  ];

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(images.length, (index) {
        return GestureDetector(
          onTap: () {
            activeIndex = index;
            setState(() {});
            widget.onChanged(index);
          },
          child: PaymentMethodItem(
            paymentMethodModel: images[index],
            isActive: index == activeIndex,
          ),
        );
      }),
    );
  }
}
