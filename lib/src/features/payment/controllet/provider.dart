import 'package:boiler_plate/src/common/provider.dart';
import 'package:boiler_plate/src/features/payment/controllet/pay_controller.dart';
import 'package:boiler_plate/src/services/stripe_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _stripe = Provider((ref) => StripeService(ref.watch(apiServiceProvider)));

final payController = Provider<PaymentController>(
    (ref) => PaymentController(stripeService: ref.watch(_stripe)));
