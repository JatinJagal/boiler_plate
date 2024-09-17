import 'package:boiler_plate/src/common/provider.dart';
import 'package:boiler_plate/src/features/auth/controller/auth_controller.dart';
import 'package:boiler_plate/src/features/auth/data/auth_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _authRepo = Provider((ref) => AuthRepo(ref.watch(apiServiceProvider)));

final authController = Provider<AuthController>(
    (ref) => AuthController(authRepo: ref.watch(_authRepo)));
