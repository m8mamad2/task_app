import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
        
        );

    //* Linux Details
    const LinuxNotificationDetails linuxNotificationDetails = LinuxNotificationDetails();

    //* Notif Details
    const NotificationDetails notificationDetails = NotificationDetails( android: androidNotificationDetails, linux: linuxNotificationDetails );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      des,
      tz.TZDateTime.now(tz.local).add(Duration( hours: hour ,minutes: minute )),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime);
  }
  
  cancleNotif(int id) async =>await flutterLocalNotificationsPlugin.cancel(id);

   a()=>flutterLocalNotificationsPlugin.getActiveNotifications();
}

