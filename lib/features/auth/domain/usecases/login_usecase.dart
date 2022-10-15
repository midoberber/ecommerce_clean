import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean/core/error/failures.dart';
import 'package:ecommerce_clean/core/usecases/usecase.dart';
import 'package:ecommerce_clean/features/auth/data/models/login_response.dart';
import 'package:ecommerce_clean/features/auth/domain/entities/login_entitie.dart';
import 'package:ecommerce_clean/features/auth/domain/repositories/auth_repositories.dart';

class LoginUsecas extends UseCase<LoginResponse, LoginParams> {
  final AuthRepository authRepository;

  LoginUsecas({required this.authRepository});

  @override
  Future<Either<Failure, LoginResponse>> call(LoginParams loginParams) =>
      authRepository.login(loginParams: loginParams);
}

class LoginParams {
  final String email;
  final String password;
  final String fcmToken;

  LoginParams({
    this.email = "",
    this.password = "",
    this.fcmToken = "",
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "fcm_token": fcmToken,
      };
}
