part of 'logics_cubit.dart';

sealed class LogicsState {}

final class LogicsInitial extends LogicsState {}

final class SignUpLoading extends LogicsState {}

final class SignUpSuccess extends LogicsState {
  final String message;

  SignUpSuccess(this.message);
}

final class SignUpFailure extends LogicsState {
  final String error;

  SignUpFailure(this.error);
}

final class LoginLoading extends LogicsState {}

final class LoginSuccess extends LogicsState {
  final String message;

  LoginSuccess(this.message);
}

final class LoginFailure extends LogicsState {
  final String error;

  LoginFailure(this.error);
}


