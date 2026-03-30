import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_ease/features/onboarding/model/onboarding_model.dart';

class OnboardingItem extends StatelessWidget {
  const OnboardingItem({super.key, required this.onboardingModel});

  final OnboardingModel onboardingModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 400.h,
          width: double.infinity,
          child: Image.asset(onboardingModel.image, fit: BoxFit.scaleDown),
        ),
        SizedBox(height: 12.h),
        Text(
          onboardingModel.title,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        SizedBox(height: 8.h),
        Text(
          onboardingModel.description,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ],
    );
  }
}
