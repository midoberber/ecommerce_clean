import 'package:ecommerce_clean/app/app_repository.dart';
import 'package:ecommerce_clean/app/app_storage.dart';
import 'package:ecommerce_clean/app/cubit_app_main/bloc_main_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initAppMainjection(GetIt sl) async {
  //* cubit

  sl.registerFactory<BlocMainCubit>(() => BlocMainCubit(repository: sl()));

}
