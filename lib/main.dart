import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'app.dart';
import 'core/services/cache_helper.dart';
import 'core/utils/api_keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  Stripe.publishableKey = ApiKeys.publishableKey;
  await ScreenUtil.ensureScreenSize();
  await CacheHelper().init();
  // await CacheHelper().removeData(key: "onboarding_complete");

  runApp(const MarketEase());
}
