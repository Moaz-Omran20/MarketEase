import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:market_ease/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:market_ease/features/wishlist/presentation/view/wishlist_view.dart';
import 'package:market_ease/features/wishlist/presentation/view_model/wishlist_cubit.dart';

import '../core/data_source/remote/api_service.dart';
import '../core/routes/app_routes.dart';
import '../core/services/cache_helper.dart';
import '../generated/assets.dart';
import 'brands/data/repo/brands_implementation.dart';
import 'brands/presentation/view/brands_view.dart';
import 'brands/presentation/view_model/brands_cubit.dart';
import 'cart/presentation/view/cart_view.dart';
import 'home/data/repo/category_implementation.dart';
import 'home/presentation/view/home_view.dart';
import 'home/presentation/view_model/categories_cubit.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> screens = [
    BlocProvider(
      create: (context) =>
          CategoriesCubit(CategoryImplementation(ApiService())),
      child: const HomeView(),
    ),
    BlocProvider(
      create: (context) => BrandsCubit(BrandsImplementation(ApiService())),
      child: const BrandsView(),
    ),
    const WishlistView(),
    const CartView(),
  ];

  int currentIndex = 0;
  String? userImagePath;

  @override
  void initState() {
    super.initState();
    userImagePath = CacheHelper().getDataString(key: 'user_image');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        enableFeedback: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: "Brands",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outlined),
            label: "Wishlist",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
        ],
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });

          if (currentIndex == 3) {
            context.read<CartCubit>().getCart();
          }
          if (currentIndex == 2) {
            context.read<WishlistCubit>().getWishlist();
          }
        },
      ),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: userImagePath == null
                ? IconButton(
                    onPressed: () {
                      context.push(AppRoutes.kProfileView);
                    },
                    icon: const Icon(Icons.person),
                  )
                : InkWell(
                    onTap: () {
                      context.push(AppRoutes.kProfileView);
                    },
                    child: CircleAvatar(
                      radius: 18,
                      backgroundImage: FileImage(File(userImagePath!)),
                    ),
                  ),
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SvgPicture.asset(Assets.imagesMarketEaseLogo),
        ),
        title: Text(
          "MarketEase",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: IndexedStack(index: currentIndex, children: screens),
    );
  }
}
