import 'package:auto_route/auto_route.dart';
import 'package:boiler_plate/src/common/global.dart';
import 'package:boiler_plate/src/features/auth/controller/providers.dart';
import 'package:boiler_plate/src/features/auth/presentation/widgets/auth_button.dart';
import 'package:boiler_plate/src/features/auth/presentation/widgets/text_field_widget.dart';
import 'package:boiler_plate/src/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

@RoutePage()
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFieldWidget(
                prefixIcon: Icons.mail,
                label: "Name",
                controller: nameController,
                validator: (value) {
                  if (value!.isEmpty || value == "") {
                    return "Fill required field";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                validator: (value) {
                  if (value!.isEmpty || value == "") {
                    return "Fill required field";
                  }
                  return null;
                },
                prefixIcon: Icons.lock,
                label: "Password",
                controller: passController,
              ),
              const SizedBox(
                height: 10,
              ),
              AuthButton(
                  label: "Login",
                  onPress: () async {
                    if (_formKey.currentState!.validate()) {
                      final data = {
                        "username": nameController.text,
                        "password": passController.text
                      };
                      final result = await ref.read(authController).login(data);
                      if (result.isRight) {
                        // ignore: unnecessary_null_comparison
                        if (result.right != null) {
                          Fluttertoast.showToast(msg: "Login successfully");
                          getIt<AppRouter>().pushAndPopUntil(
                            const HomeRoute(),
                            predicate: (route) => false,
                          );
                        }
                      } else if (result.isLeft) {
                        Fluttertoast.showToast(msg: result.left);
                      } else {
                        Fluttertoast.showToast(msg: "Something went wrong!");
                      }
                    }
                  },
                  size: const Size(400, 50),
                  color: Colors.black)
            ],
          ),
        ),
      ),
    );
  }
}
