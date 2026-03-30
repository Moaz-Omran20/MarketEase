import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:market_ease/core/shared_widgets/snack_bar.dart';
import '../../../../../generated/assets.dart';

class GoogleAuthWidget extends StatelessWidget {
  const GoogleAuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            SnackBarCustom.showFailureSnackBar(context, "This feature will be added soon...");
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(12),
              border: BoxBorder.all(color: Color(0xFF334155)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 4.h),
              child: Row(
                children: [
                  SvgPicture.asset(Assets.imagesGoogle),
                  SizedBox(width: 8),
                  Text(
                    "Google",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
