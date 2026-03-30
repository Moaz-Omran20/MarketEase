import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAuthButton extends StatelessWidget {
   const CustomAuthButton({super.key,required this.title,required this.onPressed});

 final String title;
 final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed:() => onPressed!(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.labelMedium,
            ),
            SizedBox(width: 16),
            Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}
