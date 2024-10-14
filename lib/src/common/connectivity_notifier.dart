import 'package:boiler_plate/src/common/global.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConnectivityStatusNotifier extends StateNotifier<ConnectivityStatus> {
  ConnectivityStatus? lastResult;
  ConnectivityStatus? newState;
  ConnectivityStatusNotifier() : super(ConnectivityStatus.Connected) {
    if (state == ConnectivityStatus.Connected) {
      lastResult = ConnectivityStatus.Connected;
    } else {
      lastResult = ConnectivityStatus.NotConnected;
    }
    lastResult = ConnectivityStatus.NotDitermined;
    Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        switch (result) {
          case ConnectivityResult.mobile:
          case ConnectivityResult.wifi:
            newState = ConnectivityStatus.Connected;
            break;
          case ConnectivityResult.none:
            newState = ConnectivityStatus.NotConnected;
            break;
          default:
        }
      },
    );
  }
}
