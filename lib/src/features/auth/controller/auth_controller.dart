import 'package:boiler_plate/src/features/auth/data/auth_repo.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AuthController {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  Future<Either<String, Map<String, dynamic>>> login(
      Map<String, dynamic> data) async {
    EasyLoading.show();
    final result = await authRepo.login(data);

    return result.fold(
      (left) {
        EasyLoading.dismiss();
        return Left(left.error);
      },
      (right) {
        EasyLoading.dismiss();
        return Right(right);
      },
    );
  }
}
