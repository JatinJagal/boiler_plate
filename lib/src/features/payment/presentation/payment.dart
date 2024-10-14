import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StripeScreen extends ConsumerStatefulWidget {
  const StripeScreen({super.key});

  @override
  ConsumerState<StripeScreen> createState() => _StripeScreenState();
}

class _StripeScreenState extends ConsumerState<StripeScreen> {
  Dio dio = Dio();
  apiMethod() async {
    try {
      final res = await dio
          .get("https://3dimages.innoventixsolutions.online/api/list-images");
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stripe"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                // ref.read(payController).makePayment();
              },
              child: const Text("Make payment"))
        ],
      ),
    );
  }
}
