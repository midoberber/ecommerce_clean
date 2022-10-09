import 'package:ecommerce_clean/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean/core/usecases/usecase.dart';
import '../repositories/lang_repository.dart';

class GetSavedLangUseCase implements UseCase<String, NoParams> {
  final LangRepository langRepository;

  GetSavedLangUseCase({required this.langRepository});

  @override
  Future<Either<Failure, String>> call(NoParams params) async =>
      await langRepository.getSavedLang();
}