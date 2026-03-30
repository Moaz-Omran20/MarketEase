import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:market_ease/core/shared_models/filter_model.dart';
import 'package:market_ease/core/shared_models/product_model.dart';
import 'package:market_ease/features/auth/login/view/login_view.dart';
import 'package:market_ease/features/auth/signup/view/signup_view.dart';
import 'package:market_ease/features/checkout/presentation/view/widgets/thank_you_view.dart';
import 'package:market_ease/features/main_screen.dart';
import 'package:market_ease/features/product_details/presentation/view/product_details_view.dart';
import 'package:market_ease/features/wishlist/data/wishlist_implementation.dart';
import 'package:market_ease/features/wishlist/presentation/view_model/wishlist_cubit.dart';

import '../../features/all_products/presentation/view/all_products_view.dart';

import '../../features/cart/data/repo/cart_product_implementation.dart';
import '../../features/cart/presentation/view_model/cart_cubit.dart';
import '../../features/onboarding/onboarding.dart';
import '../../features/splash/splash_screen.dart';
import '../data_source/remote/api_service.dart';

abstract class AppRoutes {
  static const String kOnBoarding = '/onboarding';
  static const String kLoginVIew = '/loginView';
  static const String kRegisterView = '/registerView';
  static const String kMainScreen = '/mainScreen';
  static const String kAllProductsView = '/allProductsView';
  static const String kProductDetailsView = '/productDetailsView';
  static const String kThankYouView = '/thankYouView';

  static final CartCubit _cartCubit = CartCubit(
    CartProductImplementation(ApiService()),
  );

  static final WishlistCubit _wishlistCubit = WishlistCubit(
    WishlistImplementation(ApiService()),
  );

  // GoRouter configuration
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: kOnBoarding,
        builder: (context, state) => const Onboarding(),
      ),
      GoRoute(path: kLoginVIew, builder: (context, state) => const LoginView()),
      GoRoute(
        path: kRegisterView,
        builder: (context, state) => const SignupView(),
      ),
      GoRoute(
        path: kMainScreen,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: _cartCubit),
            BlocProvider.value(value: _wishlistCubit),
          ],
          child: const MainScreen(),
        ),
      ),
      GoRoute(
        path: kAllProductsView,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: _cartCubit),
            BlocProvider.value(value: _wishlistCubit),
          ],
          child: AllProductsView(filteredProduct: state.extra as FilterModel),
        ),
      ),
      GoRoute(
        path: kProductDetailsView,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: _cartCubit),
            BlocProvider.value(value: _wishlistCubit),
          ],
          child: ProductDetailsView(product: state.extra as ProductModel),
        ),
      ),
      GoRoute(
        path: kThankYouView,
        builder: (context, state) => const ThankYouView(),
      ),
    ],
  );
}
