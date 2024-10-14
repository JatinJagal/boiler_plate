import 'package:boiler_plate/src/utils/app_exception.dart';
import 'package:either_dart/either.dart';

abstract class AuthInf {
  Future<Either<AppException, Map<String, dynamic>>> login(
      Map<String, dynamic> data); //here u can also pass the datamodel in return

  // Future<Either<AppException,Map<String,dynamic>>> register(Map<String,dynamic> data);
}
