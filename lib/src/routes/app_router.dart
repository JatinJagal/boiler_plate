import 'package:auto_route/auto_route.dart';
import 'package:boiler_plate/splash_screen.dart';
import 'package:boiler_plate/src/features/auth/presentation/screens/login.dart';
import 'package:boiler_plate/src/features/home/presentation/screens/home.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: HomeRoute.page)
      ];
}
