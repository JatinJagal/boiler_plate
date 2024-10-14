import 'package:boiler_plate/src/services/api_service.dart';
import 'package:boiler_plate/src/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  final ApiService service;

  StripeService(this.service);

  var gpay = const PaymentSheetGooglePay(
      merchantCountryCode: "GB", currencyCode: "GBP", testEnv: true);

  // googlePay: const PaymentSheetGooglePay(merchantCountryCode: "+1"),

  Future<void> makePayment(int amount) async {
    try {
      String? paymentIntentClientSecret =
          await _createPaymentIntent(amount, "usd"); //usd//10, "usd"
      if (paymentIntentClientSecret == null) {
        return;
      } else {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentClientSecret,
              merchantDisplayName: "Jatin Jagal",
              googlePay: gpay),
        );
      }
      _proccessPayment();
    } catch (e) {
      print(e);
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final data = {"amount": _calculateAmount(amount), "currency": currency};
      Dio dio = Dio();
      final res = await dio.post("https://api.stripe.com/v1/payment_intents",
          data: data,
          options:
              Options(contentType: Headers.formUrlEncodedContentType, headers: {
            "Authorization": "Bearer $stripeSecreteKey",
            "Content-Type": "application/x-www-form-urlencoded"
          }));

      // if (res.isRight) {
      //   if (res.right.data != null) {
      //     print(res.right.data);
      //     return res.right.data;
      //   }
      // }
      if (res.data != null) {
        print(res.data['client_secret']);
        return res.data['client_secret'];
      }
      return null;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> _proccessPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      print(e);
    }
  }

  String _calculateAmount(int amount) {
    final calculateamount = amount * 100;
    return calculateamount.toString();
  }
}
