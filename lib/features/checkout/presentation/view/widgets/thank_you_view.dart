import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:market_ease/core/routes/app_routes.dart';

import '../../../../../generated/assets.dart';

class ThankYouView extends StatelessWidget {
  const ThankYouView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Spacer(),
            Center(child: SvgPicture.asset(Assets.imagesPaymentSuccessful)),
            SizedBox(height: 16),
            Text(
              "Payment Successful",
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(color: Color(0xFF05F300)),
            ),
            Spacer(),
            SizedBox(
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  context.pushReplacement(AppRoutes.kMainScreen);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Continue Shopping",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(width: 8,),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
