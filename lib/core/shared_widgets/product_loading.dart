import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ProductLoading extends StatelessWidget {
  const ProductLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/images/purple loading.json',
    );
  }
}
