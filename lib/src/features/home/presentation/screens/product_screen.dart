import 'package:auto_route/auto_route.dart';
import 'package:boiler_plate/src/features/cart/data/cart_data_model.dart';
import 'package:boiler_plate/src/features/home/data/model/product_data_model.dart';
import 'package:boiler_plate/src/features/home/presentation/widgets/scrollable_widget.dart';
import 'package:boiler_plate/src/features/payment/controllet/provider.dart';
import 'package:boiler_plate/src/services/database_service.dart';
import 'package:boiler_plate/src/services/storage_service.dart';
import 'package:boiler_plate/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ProductScreen extends ConsumerStatefulWidget {
  final ProductDataModel data;
  const ProductScreen({super.key, required this.data});

  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  @override
  void initState() {
    // TODO: implement initState
    // DatabaseService.i.initializeDatabase();
    getUserDetails();
    super.initState();
  }

  getUserDetails() async {
    uId = await LocalStorageService.i.getStorageValue(kUserId);
    intId = int.parse(uId);
    // print(intId);
  }

  String uId = "";
  int intId = 0;
  // String

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          // IconButton(
          //     onPressed: () {
          //       DatabaseService.i.getCartData(intId);
          //     },
          //     icon: const Icon(Icons.time_to_leave)),
          // IconButton(
          //     onPressed: () {
          //       DatabaseService.i.removeFromCart(1);
          //     },
          //     icon: const Icon(Icons.remove))
        ],
      ),
      bottomSheet: ScrollebleWidget(
        data: widget.data,
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      fixedSize: const Size(double.infinity, 50)),
                  onPressed: () {
                    // print(intId);
                    DatabaseService.i.addProductToCart(CartDataModel(
                        productId: widget.data.id!,
                        userid: intId,
                        title: widget.data.title!,
                        price: widget.data.price!,
                        image: widget.data.image!));
                    // totalP += widget.data.price!;
                  },
                  child: const Text("Add to cart",
                      style: TextStyle(color: Colors.white, fontSize: 20))),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      fixedSize: const Size(double.infinity, 50)),
                  onPressed: () {
                    // int price = int.parse(widget.data.price!.toString());
                    // print(widget.data.price!.toInt());
                    ref
                        .read(payController)
                        .makePayment(widget.data.price!.toInt());
                  },
                  child: const Text("Buy",
                      style: TextStyle(color: Colors.white, fontSize: 20))),
            ),
          )
        ],
      ),
      /**
       * ScrollebleWidget(
        data: widget.data,
      )
       */
      // floatingActionButton: ScrollebleWidget(data: widget.data),
      body: Column(
        children: [
          Image.network(
            widget.data.image!,
            fit: BoxFit.fitHeight,
          ),
        ],
      ),
    );
  }
}
/**
 * ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        fixedSize: const Size(350, 50)),
                    onPressed: () {},
                    child: const Text("Buy")),
 */
/**
 * BottomSheet(
        dragHandleSize: const Size(double.infinity, 80),
        onDragEnd: (details, {required isClosing}) {},
        onDragStart: (details) {},
        showDragHandle: false,
        onClosing: () {},
        builder: (context) {
          return Container(
            height: 400,
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.data.title!,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ))
              ],
            ),
          );
        },
      )
 */
