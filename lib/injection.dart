import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:mall/core/network/network_info.dart';
import 'package:mall/core/util/nav.dart';
import 'package:mall/features/theme/data/repositories/theme_repository_impl.dart';
import 'package:mall/features/theme/data/sources/theme_local_data_source.dart';
import 'package:mall/features/theme/data/sources/theme_remote_data_source.dart';
import 'package:mall/features/theme/domain/repositories/theme_repository.dart';
import 'package:mall/features/theme/domain/usecases/get_theme.dart';
import 'package:mall/features/theme/domain/usecases/save_theme.dart';
import 'package:mall/features/theme/presentation/ThemeViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

Future<void> init() async {
  // Storage
  final prefs = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => prefs);

  // Navigation
  locator.registerSingleton<Nav>(Nav());

  // Network
  locator.registerLazySingleton(() => DataConnectionChecker());
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // Data source
  locator.registerLazySingleton<ThemeRemoteDataSource>(
    () => ThemeRemoteDataSourceImpl(),
  );
  locator.registerLazySingleton<ThemeLocalDataSource>(
    () => ThemeLocalDataSourceImpl(prefs: locator()),
  );

  // Repository
  locator.registerLazySingleton<ThemeRepository>(
    () => ThemeRepositoryImpl(
      localDataSource: locator(),
      remoteDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  // Use case
  locator.registerLazySingleton(() => GetTheme(locator()));
  locator.registerLazySingleton(() => SaveTheme(locator()));

  // View model
  locator.registerFactory(
    () => ThemeViewModel(
      getTheme: locator(),
      saveTheme: locator(),
    ),
  );
}