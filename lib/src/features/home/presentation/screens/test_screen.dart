import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

@RoutePage()
class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late Razorpay _razorpay;
  TextEditingController amtController = TextEditingController();

  void openCheckout(amount) async {
    amount = amount;
    var option = {
      "key": "rzp_test_Kt1VU80JsyFduf",
      "amount": amount,
      "name": "jatin",
      "prefill": {"contact": "8888888888", "email": "test@razorpay.com"},
      "external": ["paytm"]
    };
    try {
      _razorpay.open(option);
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    }
  }

  void handlePaymentMethodSuccess(PaymentSuccessResponse res) async {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("${res.paymentId}")));
  }

  void handlePaymentMethodError(PaymentFailureResponse res) async {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("${res.message}")));
  }

  void handleExternalWallet(ExternalWalletResponse res) async {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("External wallet:- ${res.walletName}")));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay.clear();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentMethodSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentMethodError);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handleExternalWallet);

    super.initState();
  }

//stripe

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: amtController,
            ),
            /* ElevatedButton(
                onPressed: () {
                  if (amtController.text.isNotEmpty ||
                      amtController.text != "") {
                    openCheckout(amtController.text);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please add amount")));
                  }
                  //stripe
                  // stripeService.makePayment();
                },
                child: const Text("Pay"))*/
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.y1);
  final int x;
  final double y;
  final double y1;
}

/*
final List<ChartData> chartData = [
    ChartData(2010, 35, 0),
    ChartData(2011, 38, 0),
    ChartData(2012, 34, 0),
    ChartData(2013, 52, 0),
    ChartData(2014, 40, 0),
    ChartData(2015, 30, 0)
  ];

Column(
          children: [
            SizedBox(
                height: 400,
                child: SfCartesianChart(
                  enableAxisAnimation: false,
                  // indicators: [],
                  zoomPanBehavior: ZoomPanBehavior(
                      // zoomMode: ZoomMode.xy,
                      enableDoubleTapZooming: true,
                      maximumZoomLevel: 0.01),
                  crosshairBehavior: CrosshairBehavior(
                      enable: true, activationMode: ActivationMode.singleTap),
                  series: <CartesianSeries<ChartData, int>>[
                    // LineSeries(
                    //     dataSource: chartData,
                    //     xValueMapper: (ChartData data, _) => data.x,
                    //     yValueMapper: (ChartData data, _) => data.y),
                    LineSeries(
                        dataSource: chartData,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y)
                  ],
                )
                /* SfCartesianChart(
                    enableAxisAnimation: false,
                    // Columns will be rendered back to back
                    enableSideBySideSeriesPlacement: false,
                    series: <CartesianSeries<ChartData, int>>[
                      ColumnSeries<ChartData, int>(
                          color: Colors.red,
                          width: 0.4,
                          borderWidth: 2.0,
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y),
                      // ColumnSeries<ChartData, int>(
                      //     opacity: 0.9,
                      //     width: 0.4,
                      //     dataSource: chartData,
                      //     xValueMapper: (ChartData data, _) => data.x,
                      //     yValueMapper: (ChartData data, _) => data.y1)
                    ])*/
                ),
          ],
        )
*/