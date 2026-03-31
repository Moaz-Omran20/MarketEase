import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_ease/core/utils/app_constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../generated/assets.dart';
import 'action_button.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF140B32), // top-left: deep indigo
            Color(0xFF140B32), // mid
            Color(0xFF0F0D22), // bottom-right: near black
          ],
          stops: [0.0, 0.5, 1.0],
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.07),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Avatar with purple ring + code badge
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Outer purple ring
              Container(
                width: 108.w,
                height: 108.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF7C5CE4),
                    width: 2.5,
                  ),
                ),
              ),
              // Avatar circle
              Container(
                width: 96.w,
                height: 96.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF2A2540),
                  border: Border.all(color: const Color(0xFF3A3260), width: 1),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(Assets.imagesArchitectImage),
              ),
              // Code badge bottom-right
              Positioned(
                bottom: 0,
                right: -4,
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6941D9),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF0F0D22),
                      width: 2,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      '<>',
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Role label
          const Text(
            'ARCHITECT',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 3.5,
              color: Color(0xFF7C5CE4),
            ),
          ),

          const SizedBox(height: 8),

          // Name
          const Text(
            'Moaz Omran',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.2,
            ),
          ),

          const SizedBox(height: 12),

          // Bio
          Text(
            'Crafting high-fidelity digital experiences\nwith a focus on motion, aesthetics, and\nuser intent.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w300,
              height: 1.7,
              color: Colors.white.withValues(alpha: 0.5),
              letterSpacing: 0.1,
            ),
          ),

          const SizedBox(height: 28),

          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ActionButton(
                image: Assets.imagesLinkedin,
                onTap: () => _openLink(AppConstants.architectLinkedInLink),
              ),
              const SizedBox(width: 16),
              ActionButton(
                image: Assets.imagesGithubSvgrepoCom,
                onTap: () => _openLink(AppConstants.architectGithubLink),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<void> _openLink(String link) async {
  final Uri url = Uri.parse(link);

  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}
