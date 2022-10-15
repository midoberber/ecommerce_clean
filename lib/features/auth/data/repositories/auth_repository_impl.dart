import 'package:ecommerce_clean/core/error/exceptions.dart';
import 'package:ecommerce_clean/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean/features/auth/data/datasources/remote_datasource/auth_remotedatasource.dart';
import 'package:ecommerce_clean/features/auth/data/models/login_response.dart';
import 'package:ecommerce_clean/features/auth/data/models/register_model.dart';
import 'package:ecommerce_clean/features/auth/domain/entities/login_entitie.dart';
import 'package:ecommerce_clean/features/auth/domain/repositories/auth_repositories.dart';
import 'package:ecommerce_clean/features/auth/domain/usecases/login_usecase.dart';
import 'package:ecommerce_clean/features/auth/domain/usecases/register_usecase.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl({required this.authRemoteDatasource});

  @override
  Future<Either<Failure, LoginResponse>> login(
      {required LoginParams loginParams}) async {
    try {
      final user = await authRemoteDatasource.login(loginParams);
      // await local.cacheUserAccessToken(token: user.body.accessToken.toString());
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, RegisterResponse>> register({required RegisterParams registerParams}) async{
      try {
      final user = await authRemoteDatasource.rigester(registerParams);
      // await local.cacheUserAccessToken(token: user.body.accessToken.toString());
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
