import 'package:auto_route/auto_route.dart';
import 'package:boiler_plate/src/common/global.dart';
import 'package:boiler_plate/src/features/home/controller/provider.dart';
import 'package:boiler_plate/src/routes/app_router.dart';
import 'package:boiler_plate/src/services/storage_service.dart';
import 'package:boiler_plate/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    print("hello");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
        actions: [
          IconButton(
              onPressed: () {
                logoutPopup();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ref.watch(productStateNotifier).when(
                  initial: () => const SizedBox(),
                  loading: () => const CircularProgressIndicator(),
                  error: (error) => Text(error.error.toString()),
                  loaded: (data) => ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(data[index].title!),
                      );
                    },
                  ),
                )
          ],
        ),
      ),
    );
  }
}
