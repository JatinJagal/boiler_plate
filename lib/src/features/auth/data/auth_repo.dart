import 'package:boiler_plate/src/features/auth/data/auth_interface.dart';
import 'package:boiler_plate/src/services/api_service.dart';
import 'package:boiler_plate/src/services/storage_service.dart';
import 'package:boiler_plate/src/utils/app_exception.dart';
import 'package:boiler_plate/src/utils/constants.dart';
import 'package:boiler_plate/src/utils/endpoints.dart';
import 'package:either_dart/src/either.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthRepo extends AuthInf {
  final ApiService apiService;
  AuthRepo(this.apiService);

  @override
  Future<Either<AppException, Map<String, dynamic>>> login(
      Map<String, dynamic> data) async {
    try {
      final res = await apiService.post(Endpoints.login, data);
      if (res.isRight) {
        if (res.right.statusCode == 200) {
          if (res.right.data != null) {
            LocalStorageService.i
                .setValueOnStorage(kToken, res.right.data['token']);
            print(res.right.data);
            return Right(res.right.data);
          }
        }
      }
      return Left(AppException(error: res.left));
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return Left(AppException(error: e.toString()));
    }
  }
}
