part of 'notif_bloc.dart';

@immutable
sealed class NotifEvent {}


class GetAllNotifEvent extends NotifEvent{}

class DeleteNotifEvent extends NotifEvent{
  final int index;
  final int id;
  final BuildContext context;
  DeleteNotifEvent(this.index,this.id,this.context);
}

class AddNotifEvent extends NotifEvent{
  final NotifModel notifModel;
  final BuildContext context;
  AddNotifEvent(this.notifModel,this.context);
}
