import 'package:dio/dio.dart';
import 'package:ecommerce_clean/app/app_repository.dart';
import 'package:ecommerce_clean/app/app_storage.dart';
import 'package:ecommerce_clean/app/injection_container_app.dart';
import 'package:ecommerce_clean/features/auth/auth_container.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ecommerce_clean/core/api/api_consumer.dart';
import 'package:ecommerce_clean/core/api/dio_consumer.dart';
import 'package:ecommerce_clean/core/network/netwok_info.dart';
import 'package:ecommerce_clean/features/splash/data/repositories/lang_repository_impl.dart';
import 'package:ecommerce_clean/features/splash/domain/repositories/lang_repository.dart';
import 'package:ecommerce_clean/features/splash/domain/usecases/change_lang.dart';
import 'package:ecommerce_clean/features/splash/domain/usecases/get_saved_lang.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features

  // Blocs
  await initAppMainjection(sl);
  await initAuthInjection(sl);

  // Use cases

  sl.registerLazySingleton<GetSavedLangUseCase>(
      () => GetSavedLangUseCase(langRepository: sl()));
  sl.registerLazySingleton<ChangeLangUseCase>(
      () => ChangeLangUseCase(langRepository: sl()));

  // Repository
  // sl.registerLazySingleton<QuoteRepository>(() => QuoteRepositoryImpl(
  //     networkInfo: sl(),
  //     randomQuoteRemoteDataSource: sl(),
  //     randomQuoteLocalDataSource: sl()));
  sl.registerLazySingleton<LangRepository>(
      () => LangRepositoryImpl(langLocalDataSource: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));

  //! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(
      () => AppRepository(KeyValueStorage(sharedPreferences)));
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Dio());
}
