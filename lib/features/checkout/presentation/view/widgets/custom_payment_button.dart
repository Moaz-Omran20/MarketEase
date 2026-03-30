import 'package:flutter/material.dart';
import 'package:market_ease/core/theme/light_colors.dart';

class CustomPaymentButton extends StatelessWidget {
 final String title;

 final Function() onTap;

  const CustomPaymentButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: LightColors.primaryColor,
        ),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelMedium!,
          ),
        ),
      ),
    );
  }
}
