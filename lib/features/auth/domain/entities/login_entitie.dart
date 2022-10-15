import 'package:equatable/equatable.dart';

class LoginEntitie extends Equatable {
  final String? token;

  const LoginEntitie(this.token);

  @override
  List<Object?> get props => [token];
}