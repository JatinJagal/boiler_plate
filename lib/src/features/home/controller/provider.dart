import 'package:boiler_plate/src/common/provider.dart';
import 'package:boiler_plate/src/features/home/controller/notifiers/product_state_notifier.dart';
import 'package:boiler_plate/src/features/home/controller/states/product_state.dart';
import 'package:boiler_plate/src/features/home/data/product_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productRepoProvider = Provider<ProductRepo>(
  (ref) => ProductRepo(apiService: ref.watch(apiServiceProvider)),
);

final productStateNotifier =
    StateNotifierProvider<ProductStateNotifier, ProductState>(
  (ref) => ProductStateNotifier(ref.watch(productRepoProvider)),
);
