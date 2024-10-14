import 'package:auto_route/auto_route.dart';
import 'package:boiler_plate/splash_screen.dart';
import 'package:boiler_plate/src/features/auth/presentation/screens/login.dart';
import 'package:boiler_plate/src/features/cart/presentation/cart.dart';
import 'package:boiler_plate/src/features/home/data/model/product_data_model.dart';
import 'package:boiler_plate/src/features/home/presentation/screens/home.dart';
import 'package:boiler_plate/src/features/home/presentation/screens/product_screen.dart';
import 'package:boiler_plate/src/features/home/presentation/screens/test_screen.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: ProductRoute.page),
        AutoRoute(page: TestRoute.page),
        AutoRoute(page: CartRoute.page)
      ];
}
