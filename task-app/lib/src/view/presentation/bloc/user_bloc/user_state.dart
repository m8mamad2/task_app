part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class InitialUserState extends UserState {}

final class LoadingUserState extends UserState {}

final class SucessUserState extends UserState {
  final UserModelLocaly? data;
  SucessUserState(this.data);
}

final class FailUserState extends UserState {
  final String fail;
  FailUserState(this.fail);
}
