part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class InitialAuthState extends AuthState {}
final class LoadingAuthState extends AuthState {}
final class SuccessAuthState extends AuthState {}
final class FailAuthState extends AuthState {
  final String error;
  FailAuthState(this.error);
}
