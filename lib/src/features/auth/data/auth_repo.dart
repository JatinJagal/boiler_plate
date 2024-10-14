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
            getAllUsers(data['username']);
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

  Future<void> getAllUsers(String username) async {
    final res = await apiService.get("users");

    if (res.right!.statusCode == 200) {
      final data = res.right!.data;
      for (final i in data) {
        if (i['username'] == username) {
          print(i);
          LocalStorageService.i.setValueOnStorage(kMail, i["email"].toString());
          LocalStorageService.i
              .setValueOnStorage(kStreet, i["address"]["street"].toString());
          LocalStorageService.i
              .setValueOnStorage(kCity, i["address"]["city"].toString());
          LocalStorageService.i
              .setValueOnStorage(kNumber, i["address"]["number"].toString());
          LocalStorageService.i
              .setValueOnStorage(kZipcode, i["address"]["zipcode"].toString());
          LocalStorageService.i
              .setValueOnStorage(kPhone, i["phone"].toString());
          LocalStorageService.i
              .setValueOnStorage(kUsername, i["username"].toString());
          LocalStorageService.i.setValueOnStorage(kUserId, i["id"].toString());
        } else {
          print("Username does not exist");
        }
      }
    }
  }

  // @override
  // Future<Either<AppException, Map<String, dynamic>>> register(Map<String, dynamic> data) async{
  //   try {
  //     final res = apiService.post(Endpoints.register, data);
  //     if(res.r)
  //   } catch (e) {

  //   }
  // }
}
