import 'package:boiler_plate/src/features/cart/data/cart_res_model.dart';
import 'package:boiler_plate/src/utils/app_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part "cart_state.freezed.dart";

@freezed
abstract class CartState with _$CartState {
  const factory CartState.initial() = Initial;
  const factory CartState.loading() = Loading;
  const factory CartState.error(AppException error) = Failure;
  const factory CartState.loaded(List<CartResponsModel> data) = Loaded;
}
