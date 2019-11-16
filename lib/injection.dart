import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:mall/core/network/network_info.dart';
import 'package:mall/core/util/nav.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

Future<void> init() async {
  locator.registerSingleton<Nav>(Nav());

  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);

  locator.registerLazySingleton(() => DataConnectionChecker());
  locator.registerLazySingleton<NetworkConnection>(() => NetworkInfo(locator()));
}
