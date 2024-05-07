// ignore_for_file: depend_on_referenced_packages, curly_braces_in_flow_control_structures

import "package:flutter/foundation.dart";
import "package:hive/hive.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:path_provider/path_provider.dart";
import "package:taskapp/src/view/data/model/notif_model.dart";
import "package:taskapp/src/view/data/model/user_model_localy.dart";

List<Box> boxList = [];

Future<List<Box>> openBoxes() async {

  if(kIsWeb) {
    Hive.initFlutter();
  }
  else {
    print('in Not Web');
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
  }

  Hive.registerAdapter(NotifModelAdapter());
  Hive.registerAdapter(UserModelLocalyAdapter());

  var notifBox = await Hive.openBox<NotifModel>('noti_box');
  var tokenBox = await Hive.openBox<String>('token_box');
  var userBox =  await Hive.openBox<UserModelLocaly>('user_box');

  boxList.add(notifBox);
  boxList.add(tokenBox);
  boxList.add(userBox);
  
  return boxList;
}
