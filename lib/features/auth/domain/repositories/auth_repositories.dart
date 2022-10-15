import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean/core/error/failures.dart';
import 'package:ecommerce_clean/features/auth/data/models/login_response.dart';
import 'package:ecommerce_clean/features/auth/data/models/register_model.dart';
import 'package:ecommerce_clean/features/auth/domain/entities/login_entitie.dart';
import 'package:ecommerce_clean/features/auth/domain/usecases/login_usecase.dart';
import 'package:ecommerce_clean/features/auth/domain/usecases/register_usecase.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginResponse>> login({required LoginParams loginParams});
    Future<Either<Failure, RegisterResponse>> register({required RegisterParams registerParams});

}
