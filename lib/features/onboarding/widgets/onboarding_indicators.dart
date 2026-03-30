import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingIndicators extends StatelessWidget {
  const OnboardingIndicators({super.key,required this.currentIndex,required this.listLength});


  final int currentIndex ;
  final int listLength;

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        listLength,
            (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8.h,
          width:  currentIndex == index ?18.w :8.w,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColor.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      ),
    );
  }
}
