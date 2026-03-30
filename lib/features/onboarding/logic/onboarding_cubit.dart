import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_ease/core/services/cache_helper.dart';
import 'package:market_ease/features/onboarding/logic/onboarding_state.dart';
import 'package:market_ease/features/onboarding/model/onboarding_model.dart';
import '../../../generated/assets.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  final PageController pageController = PageController();
  int currentIndex = 0;

  final List<OnboardingModel> onboardingList = [
    OnboardingModel(
      image: Assets.imagesOnboarding1,
      title: "Trendsetting Style",
      description:
          "Discover the latest in high-end fashion and everyday wear curated just for you.",
    ),
    OnboardingModel(
      image: Assets.imagesOnboarding2,
      title: "Cutting Edge Tech ",
      description:
          "Upgrade your life with the newest gadgets, smartphones, and home electronics.",
    ),
    OnboardingModel(
      image: Assets.imagesOnboarding3,
      title: "Shopping Made Simple",
      description:
          "From essentials to luxuries, get everything you need delivered fast and securely.",
    ),
  ];

  void onPageChanged(int index) {
    currentIndex = index;
    emit(OnboardingPageChanged(currentIndex));
  }

  void next(BuildContext context) {
    if (currentIndex == onboardingList.length - 1) {
      onFinish(context);
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    }
  }

  void onFinish(BuildContext context) async {
    await CacheHelper().put(key: "onboarding_complete", value: true);
    emit(OnboardingCompleted());
  }
}
