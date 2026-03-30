import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class CartEmptyWidget extends StatelessWidget {
  const CartEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            height: 200.h,
            width: 200.w,
            child: Lottie.asset(
              fit: BoxFit.fill,
              'assets/images/Empty Cart.json',
            ),
          ),
        ),
        Text("Your shopping cart looks empty.",style: Theme.of(context).textTheme.displayLarge,),
      ],
    );
  }
}
