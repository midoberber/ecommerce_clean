import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean/core/error/failures.dart';
import 'package:ecommerce_clean/core/usecases/usecase.dart';
import 'package:ecommerce_clean/features/auth/data/models/register_model.dart';
import 'package:ecommerce_clean/features/auth/domain/repositories/auth_repositories.dart';

class RegisterUsecas extends UseCase<RegisterResponse, RegisterParams> {
  final AuthRepository authRepository;

  RegisterUsecas({required this.authRepository});

  @override
  Future<Either<Failure, RegisterResponse>> call(
          RegisterParams params) =>
      authRepository.register(registerParams: params);
}

class RegisterParams {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String phone;
  final String fcmToken;

  RegisterParams({
    this.email = "",
    this.password = "",
    this.fcmToken = "",
    this.name = "",
    this.confirmPassword = "",
    this.phone = "",
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": confirmPassword,
        "phone": phone,
        "fcm_token": fcmToken,
      };
}
