import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:market_ease/features/auth/login/view/login_view.dart';
import 'package:market_ease/features/onboarding/logic/onboarding_cubit.dart';
import 'package:market_ease/features/onboarding/logic/onboarding_state.dart';
import 'package:market_ease/features/onboarding/widgets/onboarding_indicators.dart';
import 'package:market_ease/features/onboarding/widgets/onboarding_item.dart';

import '../../generated/assets.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: BlocConsumer<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingCompleted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginView()),
            );
          }
        },
        builder: (context, state) {
          var cubit = context.read<OnboardingCubit>();
          return Scaffold(
            appBar: AppBar(
              title: const Text("MarketEase"),
              leading: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: SizedBox(
                  width: 10,
                  height: 10,
                  child: SvgPicture.asset(Assets.imagesMarketEaseLogo),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(
                    height: 500.h,
                    child: PageView.builder(
                      itemCount: cubit.onboardingList.length,
                      controller: cubit.pageController,
                      onPageChanged: cubit.onPageChanged,
                      itemBuilder: (context, index) {
                        return OnboardingItem(
                          onboardingModel: cubit.onboardingList[index],
                        );
                      },
                    ),
                  ),
                  OnboardingIndicators(
                    currentIndex: cubit.currentIndex,
                    listLength: cubit.onboardingList.length,
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 52.h,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => cubit.next(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            cubit.currentIndex == cubit.onboardingList.length - 1
                                ? "Get Started"
                                : "Next",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          const SizedBox(width: 16),
                          const Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
