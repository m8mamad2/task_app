
import 'package:flutter/material.dart';
import 'package:taskapp/src/config/locator.dart';
import 'package:taskapp/src/config/multi_bloc_providers.dart';
import 'package:taskapp/src/config/notification_setup.dart';
import 'package:taskapp/src/config/theme.dart';
import 'package:taskapp/src/view/data/data_source/local/loacl_db.dart';
import 'package:taskapp/src/view/presentation/screen/splash_screen.dart';


void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();

  //* notificaton
  await LocalNotificationSetup.notifInitialization();

  //* initi DB < Hive >
  await openBoxes();

  //* get it Setup
  await getItSetup();

  runApp(multiBlocProviders(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        home: const SplashScreen(),
    );
  }
}
 