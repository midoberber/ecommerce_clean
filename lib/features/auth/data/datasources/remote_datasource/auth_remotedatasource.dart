import 'package:ecommerce_clean/core/api/api_consumer.dart';
import 'package:ecommerce_clean/core/api/end_points.dart';
import 'package:ecommerce_clean/core/error/exceptions.dart';
import 'package:ecommerce_clean/features/auth/data/models/login_response.dart';
import 'package:ecommerce_clean/features/auth/data/models/register_model.dart';
import 'package:ecommerce_clean/features/auth/domain/usecases/login_usecase.dart';
import 'package:ecommerce_clean/features/auth/domain/usecases/register_usecase.dart';

abstract class AuthRemoteDatasource {
  Future<LoginResponse> login(LoginParams loginParams);
  Future<RegisterResponse> rigester(RegisterParams loginParams);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  ApiConsumer apiConsumer;

  AuthRemoteDatasourceImpl({required this.apiConsumer});

  @override
  Future<LoginResponse> login(LoginParams loginParams) async {
    try {
      final response =
          await apiConsumer.post("${EndPoints.baseUrl}api/login", body: {
        "email": loginParams.email.trim(),
        "password": loginParams.password.trim(),
      });
      final result = LoginResponse.fromJson(response);

      if (result.success == true) {
        return result;
      } else {
        throw ServerException(result.message);
      }
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<RegisterResponse> rigester(RegisterParams registerParams) async {
    try {
      final response =
          await apiConsumer.post("${EndPoints.baseUrl}api/register", body: {
        "name": registerParams.name.trim(),
        "email": registerParams.email.trim(),
        "password": registerParams.password.trim(),
        "password_confirmation": registerParams.confirmPassword.trim(),
        "phone": registerParams.phone.trim()
      });
      final result = RegisterResponse.fromJson(response);

      if (result.success == true) {
        return result;
      } else {
        throw ServerException(result.message);
      }
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }
}
