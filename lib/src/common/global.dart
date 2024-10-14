import 'package:get_it/get_it.dart';

bool isTestServer = true;

final getIt = GetIt.I;

enum ConnectivityStatus { NotConnected, Connected, NotDitermined }

double totalP = 0.0;
