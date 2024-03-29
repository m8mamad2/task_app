import 'package:taskapp/src/view/data/data_source/local/loacl_db.dart';

Future<bool> isUserLoggin()async{
  String? token = await boxList[1].values.firstOrNull;
  if(token == null || token.isEmpty)return false;
  return true;
}