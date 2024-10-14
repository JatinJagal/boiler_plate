import 'package:boiler_plate/src/features/cart/controller/states/cart_state.dart';
import 'package:boiler_plate/src/services/database_service.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartStateNotiFier extends StateNotifier<CartState> {
  CartStateNotiFier() : super(const CartState.initial());

  Future getAllCart(int userId) async {
    state = const CartState.loading();

    DatabaseService.i.getCartData(userId).either(
      (left) {
        state = CartState.error(left);
      },
      (right) {
        // print(right);
        state = CartState.loaded(right);
      },
    );
  }
}
