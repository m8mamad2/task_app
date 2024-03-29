import 'package:taskapp/src/view/data/model/notif_model.dart';

abstract class NotifRepoHeader{
  Future addNotif(NotifModel data);
  Future deleteNotif(int index,int id);
  List<NotifModel> getAllNotif();
}