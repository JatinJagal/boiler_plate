import 'package:boiler_plate/src/features/cart/controller/notifiers/cart_state_notifier.dart';
import 'package:boiler_plate/src/features/cart/controller/states/cart_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartStateNotifierProvider =
    StateNotifierProvider<CartStateNotiFier, CartState>(
        (ref) => CartStateNotiFier());
