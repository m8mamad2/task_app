import 'package:flutter/material.dart';

class Keys {
  static final bottomNavigationShet = GlobalKey<ScaffoldState>(debugLabel: 'Drawer');
  static final addNotifBottomShetKey = GlobalKey<FormState>(debugLabel: 'add_notif_key');
  static final changeInfoBottomShetKey = GlobalKey<FormState>(debugLabel: 'change_info_key');
  static final signupKey =  GlobalKey<FormState>(debugLabel: 'signup_from');
  static final loginKey =  GlobalKey<FormState>(debugLabel: 'signup_from');
  static final loginDesktopKey =  GlobalKey<FormState>(debugLabel: 'login_desktop_key');
  static final signupDesktopKey =  GlobalKey<FormState>(debugLabel: 'signup_desktop_key');
  static final addTaskKey =  GlobalKey(debugLabel: 'add_task_key');
}