import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoProducts extends StatelessWidget {
  const NoProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset("assets/images/No Data.json");
  }
}
