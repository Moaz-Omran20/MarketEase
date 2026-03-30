import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:market_ease/core/shared_models/filter_model.dart';
import 'package:market_ease/features/home/presentation/view/widgets/category_item.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/shared_widgets/product_loading.dart';
import '../../../../generated/assets.dart';
import '../../../onboarding/widgets/onboarding_indicators.dart';
import '../view_model/categories_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<String> banners = [
    Assets.imagesBanner1,
    Assets.imagesBanner2,
    Assets.imagesBanner3,
    Assets.imagesBanner4,
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 1. Carousel and Indicators
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 16.h),
              child: Column(
                children: [
                  CarouselSlider.builder(
                    itemCount: banners.length,
                    itemBuilder: (context, index, realIndex) {
                      return Image.asset(banners[index], fit: BoxFit.fill);
                    },
                    options: CarouselOptions(
                      height: 200.h,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 2),
                      autoPlayAnimationDuration: const Duration(
                        milliseconds: 800,
                      ),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  OnboardingIndicators(
                    currentIndex: currentIndex,
                    listLength: banners.length,
                  ),
                ],
              ),
            ),
          ),

          // 2. Categories Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Text(
                "Categories",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),

          // 3. Categories Grid (Reactive Sliver)
          BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesSuccess) {
                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1 / 1.5,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return InkWell(
                      onTap: () {
                        context.push(
                          AppRoutes.kAllProductsView,
                          extra: FilterModel(
                            productId: state.categories[index].id!,
                            filterType: "category[in]",
                            title: state.categories[index].name ?? "",
                          ),
                        );
                      },
                      child: CategoryItem(category: state.categories[index]),
                    );
                  }, childCount: state.categories.length),
                );
              } else if (state is CategoriesFailure) {
                return SliverToBoxAdapter(
                  child: Center(child: Text(state.errorMessage)),
                );
              } else {
                return const SliverToBoxAdapter(
                  child: Center(child: ProductLoading()),
                );
              }
            },
          ),

          // Add some bottom padding
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
