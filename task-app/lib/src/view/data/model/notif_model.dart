import 'package:hive/hive.dart';

part 'notif_model.g.dart';

@HiveType(typeId: 0)
class NotifModel {

  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final String? dec;

  @HiveField(3)
  final int? hour;

  @HiveField(4)
  final int? minute;

  @HiveField(5)
  final int? second;

  @HiveField(6)
  final String? date;

  NotifModel( this.id, this.title, this.dec, this.hour, this.minute, this.second, this.date );

}
