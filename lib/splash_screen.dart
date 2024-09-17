import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:boiler_plate/src/common/global.dart';
import 'package:boiler_plate/src/routes/app_router.dart';
import 'package:boiler_plate/src/services/storage_service.dart';
import 'package:boiler_plate/src/utils/constants.dart';
import 'package:flutter/material.dart';

@RoutePage(name: "SplashRoute")
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  navigate() async {
    var token = await LocalStorageService.i.getStorageValue(kToken);
    print(token);
    Timer(
      const Duration(seconds: 2),
      () {
        // ignore: unnecessary_null_comparison
        if (token.isNotEmpty) {
          getIt<AppRouter>().pushAndPopUntil(
            const HomeRoute(),
            predicate: (route) => false,
          );
        } else {
          getIt<AppRouter>().pushAndPopUntil(
            const LoginRoute(),
            predicate: (route) => false,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Splash Screen",
              style: TextStyle(color: Colors.black, fontSize: 26),
            ),
          ),
        ],
      ),
    );
  }
}
