import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ActionButton extends StatelessWidget {
  final String image;
  final VoidCallback onTap;

  const ActionButton({super.key,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF1E1A3A),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: SvgPicture.asset(
          image,
        ),
      ),
    );
  }
}