import 'package:boiler_plate/app.dart';
import 'package:boiler_plate/src/common/global.dart';
import 'package:boiler_plate/src/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'environments/.env');
  getIt.registerSingleton(AppRouter());
  runApp(const ProviderScope(child: App()));
}
