import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean/app/app_data.dart';
import 'package:ecommerce_clean/app/cubit_app_main/bloc_main_cubit.dart';
import 'package:ecommerce_clean/core/error/failures.dart';
import 'package:ecommerce_clean/core/usecases/usecase.dart';
import 'package:ecommerce_clean/core/utils/app_strings.dart';
import 'package:ecommerce_clean/features/auth/data/models/login_response.dart';
import 'package:ecommerce_clean/features/auth/domain/usecases/login_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.loginUsecas}) : super(LoginInitial());

  final LoginUsecas loginUsecas;

  Future<void> login(
      {required LoginParams loginParams, required BuildContext context}) async {
    emit(LoginLoadingState());
    Either<Failure, LoginResponse> response =
        await loginUsecas.call(loginParams);
    response.fold(
      (failure) => emit(LoginErrorState(message: _mapFailureToMsg(failure))),
      (success) {
        AppData appData = AppData(
          id: success.data!.id.toString(),
          displayName: success.data!.name,
          email: success.data!.email,
          phone: success.data!.phone,
          photoUrl: success.data!.photo!.originalPlaceholder,
          token: success.meta!.token,
          // typeUser: responseDecoded["data"]["user"]["type"],
          isCompleted: false,
          isSeenTutorial: true,
          isSelectLang: true,
          isGuestUser: false,
          isVerfied: false,

          // verficationCode: responseDecoded["data"]["verification_code"],
        );

        print(success.data);
        emit(LoginSuccessState(appData: appData));
      },
    );
  }

  String _mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case CacheFailure:
        return AppStrings.cacheFailure;

      default:
        return AppStrings.unexpectedError;
    }
  }
}
