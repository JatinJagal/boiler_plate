import 'package:boiler_plate/src/features/home/controller/states/product_state.dart';
import 'package:boiler_plate/src/features/home/data/product_repo.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductStateNotifier extends StateNotifier<ProductState> {
  final ProductRepo productRepo;
  ProductStateNotifier(this.productRepo) : super(const ProductState.initial());

  Future getAllProducts() async {
    state = const ProductState.loading();
    productRepo.getAllProducts().either(
      (left) {
        state = ProductState.error(left); //
      },
      (right) {
        state = ProductState.loaded(right);
      },
    );
  }
}
