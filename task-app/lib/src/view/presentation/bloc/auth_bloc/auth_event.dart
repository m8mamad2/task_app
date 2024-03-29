part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class LoginAuthEvent extends AuthEvent{
  final LoginModel data;
  LoginAuthEvent(this.data);
}
final class SignupAuthEvent extends AuthEvent{
  final SignupModel data;
  SignupAuthEvent(this.data);
}
final class ForgotPasswordAuthEvent extends AuthEvent{}