import 'package:boiler_plate/src/features/home/data/model/product_data_model.dart';
import 'package:boiler_plate/src/services/api_service.dart';
import 'package:boiler_plate/src/utils/app_exception.dart';
import 'package:boiler_plate/src/utils/endpoints.dart';
import 'package:either_dart/either.dart';

class ProductRepo {
  final ApiService apiService;

  ProductRepo({required this.apiService});

  Future<Either<AppException, List<ProductDataModel>>> getAllProducts() async {
    try {
      final res = await apiService.get(Endpoints.getProducts);
      if (res?.statusCode == 200) {
        if (res!.data != null) {
          //test
          List<ProductDataModel> data =
              List.from(res.data.map((e) => ProductDataModel.fromJson(e)));
          return Right(data);
          //
          //for return
          // return Right(res.data);
          //
          //add in model
          // final data = ProductDataModel.fromJson(res.data);
          // return data;
          //
        }
      }
      return Left(AppException(error: "Something went wrong!"));
    } catch (e) {
      return Left(AppException(error: e.toString()));
    }
  }
}
