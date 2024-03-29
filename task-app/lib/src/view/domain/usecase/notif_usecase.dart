import 'package:taskapp/src/view/data/model/notif_model.dart';
import 'package:taskapp/src/view/domain/repo/notif_repo_header.dart';

class NotifUseCase{
  
  NotifRepoHeader notifRepo;
  NotifUseCase(this.notifRepo);

  Future addNotif(NotifModel data)=> notifRepo.addNotif(data);
  Future deleteNotif(int index,int id)=> notifRepo.deleteNotif(index,id);
  List<NotifModel> getAllNotif()=> notifRepo.getAllNotif();

}

