import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TransitionLoading extends StatelessWidget {
  const TransitionLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/images/loading unfinished-50%(update).json',
    );
  }
}
