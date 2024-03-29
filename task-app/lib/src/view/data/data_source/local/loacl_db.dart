// ignore_for_file: depend_on_referenced_packages

import "package:hive/hive.dart";
import "package:path_provider/path_provider.dart";
import "package:taskapp/src/view/data/model/notif_model.dart";
import "package:taskapp/src/view/data/model/user_model_localy.dart";

List<Box> boxList = [];

Future<List<Box>> openBoxes() async {
  var directory = await getApplicationDocumentsDirectory();

  Hive.init(directory.path);
  Hive.registerAdapter(NotifModelAdapter());
  Hive.registerAdapter(UserModelLocalyAdapter());

  // Hive.isBoxOpen('noti_box');
  // Hive.isBoxOpen('token_box');

  var notifBox = await Hive.openBox<NotifModel>('noti_box');
  var tokenBox = await Hive.openBox<String>('token_box');
  var userBox =  await Hive.openBox<UserModelLocaly>('user_box');

  boxList.add(notifBox);
  boxList.add(tokenBox);
  boxList.add(userBox);
  
  return boxList;
}
