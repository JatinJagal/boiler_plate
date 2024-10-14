import 'package:auto_route/auto_route.dart';
import 'package:boiler_plate/src/common/global.dart';
import 'package:boiler_plate/src/features/cart/controller/provider.dart';
import 'package:boiler_plate/src/services/database_service.dart';
import 'package:boiler_plate/src/services/storage_service.dart';
import 'package:boiler_plate/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage(name: 'CartRoute')
class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  getUserDetails() async {
    uId = await LocalStorageService.i.getStorageValue(kUserId);
    intId = int.parse(uId);
    // DatabaseService.i.getCartData(intId);
    ref.read(cartStateNotifierProvider.notifier).getAllCart(intId);
    print(intId);
  }

  String uId = "";
  int intId = 0;

  // double totalP = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(totalP.toStringAsFixed(2).toString()),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         print(intId);
        //       },
        //       icon: const Icon(Icons.abc))
        // ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      fixedSize: const Size(double.infinity, 50)),
                  onPressed: () {},
                  child: const Text(
                    "Make Payment",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: ref.watch(cartStateNotifierProvider).when(
              initial: () => const SizedBox(),
              loading: () => const CircularProgressIndicator(),
              error: (error) {
                return Text(error.error);
              },
              loaded: (data) {
                // for (var element in data) {
                //   totalP += element.price!;
                //   // print(totalP);
                // }
                // return Text(data.length.toString());
                return ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 14.0, right: 14.0, bottom: 8.0),
                      child: ListTile(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0))),
                        tileColor: Colors.grey,
                        contentPadding: const EdgeInsets.all(8.0),
                        leading: Image.network(data[index].image!),
                        title: Text(
                          data[index].title!,
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                DatabaseService.i.removeFromCart(data[index]);
                                //remove
                                // totalP -= data[index].price!;
                                //
                                ref
                                    .read(cartStateNotifierProvider.notifier)
                                    .getAllCart(intId);
                              },
                              child: const Icon(
                                Icons.cancel_outlined,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                            Text(
                              "₹ ${data[index].price!.toString()}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
      ),
    );
  }
}
