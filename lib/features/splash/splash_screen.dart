import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:market_ease/core/services/cache_helper.dart';
import '../../core/routes/app_routes.dart';
import '../../generated/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      bool isOnboardingComplete =
          CacheHelper().getData(key: "onboarding_complete") ?? false;

      if (mounted) {
        context.go(
          isOnboardingComplete ? AppRoutes.kLoginVIew : AppRoutes.kOnBoarding,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        Assets.imagesSplashScreenBackground,
        fit: BoxFit.fill,
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
