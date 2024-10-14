import 'package:boiler_plate/src/services/stripe_service.dart';

class PaymentController {
  final StripeService stripeService;

  PaymentController({required this.stripeService});

  Future makePayment(int amount) async {
    // EasyLoading.show();
    final result = await stripeService.makePayment(amount);

    // return result.fold(
    //   (left) {
    //     EasyLoading.dismiss();
    //     return Left(left.error);
    //   },
    //   (right) {
    //     EasyLoading.dismiss();
    //     return Right(right);
    //   },
    // );
    return result;
  }
}
