import 'dart:async';

import 'dart:io' as IO;
import 'dart:js' as js;
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;


class LocalNotificationSetup{

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


  static Future notifInitialization()async{
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    const LinuxInitializationSettings initializationSettingsLinux = LinuxInitializationSettings(defaultActionName: 'Open notification');

    const InitializationSettings initializationSettings = InitializationSettings( android: initializationSettingsAndroid, linux: initializationSettingsLinux);


    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse:(notificationResponse)async {
          final String? payload = notificationResponse.payload;
          if (notificationResponse.payload != null) print('notification payload: $payload');
        }, );

    tz.initializeTimeZones();
  } 

  displayNotif(String title,String des,int hour,int minute,int id)async{
    
    //* Android Detials
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        'your channel id', 
        'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        icon: '@drawable/ic_launcher',
        color: kThiredColor);

    //* Linux Details
    const LinuxNotificationDetails linuxNotificationDetails = LinuxNotificationDetails( actionKeyAsIconName: true, defaultActionName: 'AOOOOOOoo', );

    //* Notif Details
    const NotificationDetails notificationDetails = NotificationDetails( android: androidNotificationDetails, linux: linuxNotificationDetails );

    
    if(kIsWeb){
      await Timer.periodic(
        Duration(hours: hour, minutes: minute), 
        (timer)=> js.context.callMethod("showNotification",[title,des]));
    }
    else{
      if(IO.Platform.isLinux){
        await Timer.periodic(Duration( hours: hour, minutes: minute), (timer) async => 
          await flutterLocalNotificationsPlugin.show(
            id, 
            title, 
            des, 
            notificationDetails));
      }
      else{
        await flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          title,
          des,
          tz.TZDateTime.now(tz.local).add(Duration( hours: hour ,minutes: minute )),
          notificationDetails,
          androidScheduleMode: AndroidScheduleMode.alarmClock,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime);
      }
    }

  }
  
  cancleNotif(int id) async =>await flutterLocalNotificationsPlugin.cancel(id);

}


