import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:market_ease/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:market_ease/features/wishlist/presentation/view/wishlist_view.dart';
import 'package:market_ease/features/wishlist/presentation/view_model/wishlist_cubit.dart';

import '../core/data_source/remote/api_service.dart';
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
    const WishlistView(), // Uses shared WishlistCubit from AppRoutes
    const CartView(),     // Uses shared CartCubit from AppRoutes
  ];

  int currentIndex = 0;

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
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SvgPicture.asset(Assets.imagesMarketEaseLogo),
        ),
        title: Text(
          "MarketEase",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
    );
  }
}
