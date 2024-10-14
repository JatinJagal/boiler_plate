import 'package:boiler_plate/src/common/connectivity_notifier.dart';
import 'package:boiler_plate/src/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiServiceProvider = Provider((_) => ApiService());

final connectivityStatusProviders = StateNotifierProvider((ref) {
  return ConnectivityStatusNotifier();
});
