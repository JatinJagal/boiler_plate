import 'package:auto_route/auto_route.dart';
import 'package:boiler_plate/src/common/global.dart';
import 'package:boiler_plate/src/common/provider.dart';
import 'package:boiler_plate/src/features/home/controller/provider.dart';
import 'package:boiler_plate/src/features/home/presentation/screens/product_screen.dart';
import 'package:boiler_plate/src/features/home/presentation/widgets/product_card.dart';
import 'package:boiler_plate/src/routes/app_router.dart';
import 'package:boiler_plate/src/services/database_service.dart';
import 'package:boiler_plate/src/services/storage_service.dart';
import 'package:boiler_plate/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'package:utils_package/utils/utils.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    // initial();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initial();
    });
    DatabaseService.i.initializeDatabase();
    super.initState();
  }

  void initial() {
    Future.wait([ref.read(productStateNotifier.notifier).getAllProducts()]);
  }

  logoutPopup() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Are you sure you want to logout"),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("No")),
            ElevatedButton(
                onPressed: () {
                  LocalStorageService.i.removeToken(kToken);
                  getIt<AppRouter>().pushAndPopUntil(
                    const LoginRoute(),
                    predicate: (route) => false,
                  );
                },
                child: const Text("Yes"))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var connectivity = ref.watch(connectivityStatusProviders);
    print("hello");
    // var type = MediaQuery.of(context).
    // if(Platform.)

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
        actions: [
          IconButton(
              onPressed: () {
                /* Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const TestPage(), //TestPage()//StripeScreen()
                    ));*/
                getIt<AppRouter>().push(const CartRoute());
              },
              icon: const Icon(Icons.shop_outlined)),
          IconButton(
              onPressed: () {
                logoutPopup();
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
      ]),
      // ignore: deprecated_member_use
      body: RefreshIndicator(
        onRefresh: () {
          return ref.read(productStateNotifier.notifier).getAllProducts();
        },
        child: ref.watch(productStateNotifier).when(
            initial: () => const SizedBox(),
            loading: () => GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Container(
                      width: 100.0,
                      height: 100.0,
                      padding: const EdgeInsets.all(12.0),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade500,
                        highlightColor: Colors.white,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(12.0)),
                        ),
                      ),
                    );
                  },
                ),
            error: (error) => Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LottieBuilder.asset(
                      "assets/animation/Animation - 1728034791503.json",
                      height: 100,
                      width: 100,
                    ),
                    Text(
                      error.error.toString(),
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    const Height(height: 10),
                    const Text(
                      textAlign: TextAlign.center,
                      "Please check your internet connection!",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                    const Height(height: 10),
                    ElevatedButton(
                        onPressed: () {
                          ref
                              .read(productStateNotifier.notifier)
                              .getAllProducts();
                        },
                        child: const Text("Refress"))
                  ],
                )),
            loaded: (data) => AnimationLimiter(
                  child: MasonryGridView.count(
                    crossAxisCount: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 2
                        : 4, //2
                    shrinkWrap: true,

                    mainAxisSpacing: 3.0,
                    crossAxisSpacing: 4.0, //

                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredGrid(
                        duration: const Duration(milliseconds: 1000),
                        position: index,
                        columnCount: 2,
                        child: FadeInAnimation(
                          child: InkWell(
                              onTap: () {
                                // getIt<AppRouter>().push(route);
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        duration:
                                            const Duration(milliseconds: 800),
                                        child: ProductScreen(data: data[index]),
                                        type: PageTransitionType.bottomToTop));
                              },
                              child: ProductCard(data: data[index])),
                        ),
                      );
                    },
                  ),
                )

            /*  GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: data.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.70,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0),
                itemBuilder: (context, index) {
                  return ProductCard(data: data[index]);
                },
              ),*/
            ),
      ),
    );
  }
}
/**
 * ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(data[index].title!),
                      );
                    },
                  )
 */
