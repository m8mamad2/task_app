part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

final class GetUserEvent extends UserEvent{}

final class AddUserToDBEvent extends UserEvent{}

final class UpdateUserNameEvent extends UserEvent{
  final String name;
  final BuildContext context;
  UpdateUserNameEvent(this.name,this.context);
}

final class UpdateUserAvatarEvent extends UserEvent{
  final int profileId;
  final BuildContext context;
  UpdateUserAvatarEvent(this.profileId,this.context);
}

final class DeleteUserAccountEvent extends UserEvent{
  final BuildContext context;
  DeleteUserAccountEvent(this.context);
}

final class LogoutUserEvent extends UserEvent{
  final BuildContext context;
  LogoutUserEvent(this.context);
}