import 'package:boiler_plate/src/features/home/data/model/product_data_model.dart';
import 'package:boiler_plate/src/utils/app_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part "product_state.freezed.dart";

@freezed
abstract class ProductState with _$ProductState {
  const factory ProductState.initial() = Initial;
  const factory ProductState.loading() = Loading;
  const factory ProductState.error(AppException error) = Failure;
  const factory ProductState.loaded(List<ProductDataModel> data) = Loaded;
}
