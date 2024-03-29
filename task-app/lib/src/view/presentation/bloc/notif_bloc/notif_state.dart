part of 'notif_bloc.dart';

@immutable
sealed class NotifState {}

final class InitialNotifState extends NotifState {}

final class LoadingNotifState extends NotifState {}

final class SuccessNotifState extends NotifState {
  final List<NotifModel> data;
  SuccessNotifState(this.data);
}

final class FailNotifState extends NotifState {
  final String error;
  FailNotifState(this.error);
}
