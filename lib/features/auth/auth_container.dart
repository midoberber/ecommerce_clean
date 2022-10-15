import 'package:ecommerce_clean/features/auth/data/datasources/remote_datasource/auth_remotedatasource.dart';
import 'package:ecommerce_clean/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ecommerce_clean/features/auth/domain/repositories/auth_repositories.dart';
import 'package:ecommerce_clean/features/auth/domain/usecases/login_usecase.dart';
import 'package:ecommerce_clean/features/auth/domain/usecases/register_usecase.dart';
import 'package:ecommerce_clean/features/auth/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:ecommerce_clean/features/auth/presentation/cubit/pin_code_cubit/pin_code_cubit.dart';
import 'package:get_it/get_it.dart';

import 'presentation/cubit/register_cubit/cubit/register_cubit.dart';

Future<void> initAuthInjection(GetIt sl) async {
  //* cubit

  sl.registerFactory(() => LoginCubit(loginUsecas: sl()));
  sl.registerFactory(() => RegisterCubit());
  sl.registerFactory(() => PinCodeCubit());

  
  //* Use cases
  
  sl.registerLazySingleton(() => LoginUsecas(authRepository: sl()));
  sl.registerLazySingleton(() => RegisterUsecas(authRepository: sl()));
  // sl.registerLazySingleton(() => SubmitRegister(repository: sl()));
  // sl.registerLazySingleton(() => SendLinkForgetPassword(repository: sl()));
  // sl.registerLazySingleton(() => CheckForgetPassword(repository: sl()));
  // sl.registerLazySingleton(() => ResetPassword(repository: sl()));
  // sl.registerLazySingleton(() => ChangePassword(repository: sl()));
  // sl.registerLazySingleton(() => ChangePhone(repository: sl()));
  // sl.registerLazySingleton(() => SubmitChangePhone(repository: sl()));
  // sl.registerLazySingleton(() => GetProfile(repository: sl()));
  // sl.registerLazySingleton(() => Area(repository: sl()));
  // sl.registerLazySingleton(() => EditProfile(repository: sl()));

  //* Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDatasource: sl()),
  );

  //* Data sources
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(
      apiConsumer: sl(),
      // firebaseMessaging: sl(),
    ),
  );
  // sl.registerLazySingleton<AuthLocalDataSource>(
  //   () => AuthLocalDataSourceImpl(
  //     sharedPreference: sl(),
  //   ),
  // );
}
