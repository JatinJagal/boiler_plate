import 'package:boiler_plate/app.dart';
import 'package:boiler_plate/src/common/global.dart';
import 'package:boiler_plate/src/routes/app_router.dart';
import 'package:boiler_plate/src/utils/constants.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //for stripe
  Stripe.publishableKey = stripPublishablekey;
  //
  await dotenv.load(fileName: 'environments/.env');
  getIt.registerSingleton(AppRouter());
  runApp(const ConnectivityAppWrapper(app: ProviderScope(child: App())));
}
