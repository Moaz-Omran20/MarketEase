import 'package:flutter/material.dart';

import '../../../../core/theme/light_colors.dart';

class JourneyWidget extends StatelessWidget {
  const JourneyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Eyebrow
          Text(
            'THE JOURNEY',
            style: TextStyle(color: LightColors.primaryColor),
          ),

          const SizedBox(height: 20),

          // Heading line 1
          const Text(
            'Redefining the',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w800,
              height: 1.15,
              color: Color(0xFFF0ECFF),
            ),
          ),

          // Heading line 2 — purple accent
          const Text(
            'Digital Aisle.',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w800,
              height: 1.15,
              color: Color(0xFF9B7EFF),
            ),
          ),

          const SizedBox(height: 28),

          // Body text
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF140B32), // top-left: deep indigo
                  Color(0xFF140B32), // mid
                  Color(0xFF140B32), // bottom-right: near black
                ],
                stops: [0.0, 0.5, 1.0],
              ),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.08),
                width: 1,
              ),
            ),
            child: Text(
              'MarketEase was born from a simple realization: e-commerce should feel like a discovery, not a chore. Our journey began in the pursuit of a seamless, high-velocity interface that bridges the gap between premium global brands and the discerning modern shopper. We\'ve stripped away the noise to leave only what matters—quality, speed, and elegance.',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        ],
      ),
    );
  }
}