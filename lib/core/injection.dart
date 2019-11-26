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
import 'package:mall/features/backend/data/repositories/user_repository_impl.dart';
import 'package:mall/features/backend/data/sources/user_local_data_source.dart';
import 'package:mall/features/backend/data/sources/user_remote_data_source.dart';
import 'package:mall/features/backend/domain/repositories/server_repository.dart';
import 'package:mall/features/backend/domain/repositories/user_repository.dart';
import 'package:mall/features/backend/domain/usecases/server/usecases.dart'
    as Server;
import 'package:mall/features/backend/domain/usecases/user/usecases.dart'
    as User;
import 'package:mall/features/backend/presentation/user_view_model.dart';
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
import 'package:mall/features/startup/presentation/startup_view_model.dart';
import 'package:mall/features/theme/data/repositories/theme_repository_impl.dart';
import 'package:mall/features/theme/data/sources/theme_local_data_source.dart';
import 'package:mall/features/theme/domain/repositories/theme_repository.dart';
import 'package:mall/features/theme/domain/usecases/usecases.dart' as Theme;
import 'package:mall/features/theme/presentation/theme_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

Future<void> init() async {
  /// Storage
  final prefs = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => prefs);

  /// Navigation
  locator.registerLazySingleton<Nav>(() => Nav());

  /// Network
  locator.registerLazySingleton(() => DataConnectionChecker());
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  /// Data sources
  locator.registerLazySingleton<ThemeLocalDataSource>(
    () => ThemeLocalDataSourceImpl(prefs: locator()),
  );
  locator.registerLazySingleton<SignInLocalDataSource>(
    () => SignInLocalDataSourceImpl(),
  );
  locator.registerLazySingleton<SignUpLocalDataSource>(
    () => SignUpLocalDataSourceImpl(),
  );
  locator.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(),
  );
  locator.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(),
  );
  locator.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(),
  );

  /// Repositories
  locator.registerLazySingleton<ThemeRepository>(
    () => ThemeRepositoryImpl(localDataSource: locator()),
  );
  locator.registerLazySingleton<SignInRepository>(
    () => SignInRepositoryImpl(localDataSource: locator()),
  );
  locator.registerLazySingleton<SignUpRepository>(
    () => SignUpRepositoryImpl(localDataSource: locator()),
  );
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(localDataSource: locator()),
  );
  locator.registerLazySingleton<ServerRepository>(
    () => ServerRepositoryImpl(networkInfo: locator()),
  );
  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      localDataSource: locator(),
      remoteDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  /// View models
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
  locator.registerFactory(() => UserViewModel(
        getData: locator(),
        setDisplayImagePath: locator(),
        setEmailAddress: locator(),
        setName: locator(),
        setPassword: locator(),
        setType: locator(),
        destroy: locator(),
        save: locator(),
        signIn: locator(),
        signInAnonymous: locator(),
        signOut: locator(),
        signUp: locator(),
      ));

  /// Use cases
  locator.registerFactory(() => Theme.GetData(locator()));
  locator.registerFactory(() => Theme.SetData(locator()));
  locator.registerFactory(() => SignIn.GetData(locator()));
  locator.registerFactory(() => SignIn.SetData(locator()));
  locator.registerFactory(() => SignIn.SetUsername(locator()));
  locator.registerFactory(() => SignIn.SetPassword(locator()));
  locator.registerFactory(() => SignIn.SetObscurePassword(locator()));
  locator.registerFactory(() => SignUp.GetData(locator()));
  locator.registerFactory(() => SignUp.SetData(locator()));
  locator.registerFactory(() => SignUp.SetUsername(locator()));
  locator.registerFactory(() => SignUp.SetPassword(locator()));
  locator.registerFactory(() => SignUp.SetRepeatPassword(locator()));
  locator.registerFactory(() => SignUp.SetEmailAddress(locator()));
  locator.registerFactory(() => SignUp.SetObscurePassword(locator()));
  locator.registerFactory(() => Auth.GetData(locator()));
  locator.registerFactory(() => Auth.SetData(locator()));
  locator.registerFactory(() => Server.Initialization(locator()));
  locator.registerFactory(() => User.GetData(locator()));
  locator.registerFactory(() => User.SetDisplayImagePath(locator()));
  locator.registerFactory(() => User.SetEmailAddress(locator()));
  locator.registerFactory(() => User.SetName(locator()));
  locator.registerFactory(() => User.SetPassword(locator()));
  locator.registerFactory(() => User.SetType(locator()));
  locator.registerFactory(() => User.Destroy(locator()));
  locator.registerFactory(() => User.Save(locator()));
  locator.registerFactory(() => User.SignIn(locator()));
  locator.registerFactory(() => User.SignInAnonymous(locator()));
  locator.registerFactory(() => User.SignOut(locator()));
  locator.registerFactory(() => User.SignUp(locator()));
}
