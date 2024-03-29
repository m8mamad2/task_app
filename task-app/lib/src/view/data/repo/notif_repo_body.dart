import 'dart:developer';

import 'package:taskapp/src/config/notification_setup.dart';
import 'package:taskapp/src/view/data/data_source/local/loacl_db.dart';
import 'package:taskapp/src/view/data/model/notif_model.dart';
import 'package:taskapp/src/view/domain/repo/notif_repo_header.dart';

class NotifRepoBody extends NotifRepoHeader{
  
  LocalNotificationSetup notifService; 
  NotifRepoBody(this.notifService);
  
  @override
  Future addNotif(NotifModel data) async {
    try{
      await notifService.displayNotif(  data.title!,  data.dec ?? '',  data.hour ?? 0,  data.minute ?? 0, data.id!);
      await boxList[0].put(data.id, data);
      return true;
    }
    catch(e){
      log('id Add Notif $e');
      return false;
    }
    
  }

  @override
  List<NotifModel> getAllNotif() => boxList[0].values.toList() as List<NotifModel>;
  
  @override
  Future deleteNotif(int index,int id) async {
    await notifService.cancleNotif(id);
    await boxList[0].deleteAt(index);
  }
  
}