part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}
class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
 final AppData appData;

  const LoginSuccessState({required this.appData});
}

class LoginErrorState extends LoginState {
  final String message;
  LoginErrorState({required this.message});
}
