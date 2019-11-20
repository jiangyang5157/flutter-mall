import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:mall/core/network/network_info.dart';
import 'package:mall/core/util/nav.dart';
import 'package:mall/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mall/features/auth/data/sources/auth_local_data_source.dart';
import 'package:mall/features/auth/domain/repositories/auth_repository.dart';
import 'package:mall/features/auth/domain/usecases/usecases.dart' as Auth;
import 'package:mall/features/auth/presentation/auth_view_model.dart';
import 'package:mall/features/backend/data/repositories/server_repository_impl.dart';
import 'package:mall/features/backend/domain/repositories/server_repository.dart';
import 'package:mall/features/signin/data/repositories/sign_in_repository_impl.dart';
import 'package:mall/features/signin/data/sources/sign_in_local_data_source.dart';
import 'package:mall/features/signin/domain/repositories/sign_in_repository.dart';
import 'package:mall/features/signin/domain/usecases/usecases.dart' as SignIn;
import 'package:mall/features/signin/presentation/sign_in_view_model.dart';
import 'package:mall/features/signup/data/repositories/sign_up_repository_impl.dart';
import 'package:mall/features/signup/data/sources/sign_up_local_data_source.dart';
import 'package:mall/features/signup/domain/repositories/sign_up_repository.dart';
import 'package:mall/features/signup/domain/usecases/usecases.dart' as SignUp;
import 'package:mall/features/signup/presentation/sign_up_view_model.dart';
import 'package:mall/features/backend/domain/usecases/usecases.dart' as Backend;
import 'package:mall/features/startup/presentation/startup_view_model.dart';
import 'package:mall/features/theme/data/repositories/theme_repository_impl.dart';
import 'package:mall/features/theme/data/sources/theme_local_data_source.dart';
import 'package:mall/features/theme/domain/repositories/theme_repository.dart';
import 'package:mall/features/theme/domain/usecases/usecases.dart' as Theme;
import 'package:mall/features/theme/presentation/theme_view_model.dart';
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
  locator.registerLazySingleton<ThemeLocalDataSource>(
      () => ThemeLocalDataSourceImpl(prefs: locator()));
  locator.registerLazySingleton<SignInLocalDataSource>(
      () => SignInLocalDataSourceImpl());
  locator.registerLazySingleton<SignUpLocalDataSource>(
      () => SignUpLocalDataSourceImpl());
  locator.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl());

  // Repository
  locator.registerLazySingleton<ThemeRepository>(
      () => ThemeRepositoryImpl(localDataSource: locator()));
  locator.registerLazySingleton<SignInRepository>(
      () => SignInRepositoryImpl(localDataSource: locator()));
  locator.registerLazySingleton<SignUpRepository>(
      () => SignUpRepositoryImpl(localDataSource: locator()));
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(localDataSource: locator()));
  locator
      .registerLazySingleton<ServerRepository>(() => ServerRepositoryImpl());

  // Use case
  locator.registerLazySingleton(() => Theme.GetData(locator()));
  locator.registerLazySingleton(() => Theme.SetData(locator()));
  locator.registerLazySingleton(() => SignIn.GetData(locator()));
  locator.registerLazySingleton(() => SignIn.SetData(locator()));
  locator.registerLazySingleton(() => SignIn.SetUsername(locator()));
  locator.registerLazySingleton(() => SignIn.SetPassword(locator()));
  locator.registerLazySingleton(() => SignIn.SetObscurePassword(locator()));
  locator.registerLazySingleton(() => SignUp.GetData(locator()));
  locator.registerLazySingleton(() => SignUp.SetData(locator()));
  locator.registerLazySingleton(() => SignUp.SetUsername(locator()));
  locator.registerLazySingleton(() => SignUp.SetPassword(locator()));
  locator.registerLazySingleton(() => SignUp.SetRepeatPassword(locator()));
  locator.registerLazySingleton(() => SignUp.SetEmailAddress(locator()));
  locator.registerLazySingleton(() => SignUp.SetObscurePassword(locator()));
  locator.registerLazySingleton(() => Auth.GetData(locator()));
  locator.registerLazySingleton(() => Auth.SetData(locator()));
  locator.registerLazySingleton(() => Backend.Initialization(locator()));

  // View model
  locator.registerFactory(() => ThemeViewModel(
        getData: locator(),
        setData: locator(),
      ));
  locator.registerFactory(() => SignInViewModel(
        getData: locator(),
        setData: locator(),
        setUsername: locator(),
        setPassword: locator(),
        setObscurePassword: locator(),
      ));
  locator.registerFactory(() => SignUpViewModel(
        getData: locator(),
        setData: locator(),
        setUsername: locator(),
        setPassword: locator(),
        setRepeatPassword: locator(),
        setEmailAddress: locator(),
        setObscurePassword: locator(),
      ));
  locator.registerFactory(() => AuthViewModel(
        getData: locator(),
        setData: locator(),
      ));
  locator.registerFactory(() => StartupViewModel(
        initialization: locator(),
      ));
}
