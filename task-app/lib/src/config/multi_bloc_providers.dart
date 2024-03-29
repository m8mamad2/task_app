import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/src/config/locator.dart';
import 'package:taskapp/src/view/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:taskapp/src/view/presentation/bloc/notif_bloc/notif_bloc.dart';
import 'package:taskapp/src/view/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:taskapp/src/view/presentation/bloc/task_bloc/task_bloc.dart';
import 'package:taskapp/src/view/presentation/bloc/user_bloc/user_bloc.dart';



Widget multiBlocProviders(Widget child)=>MultiBlocProvider(
      providers: [
        BlocProvider<NotifBloc>(create:(_) => NotifBloc(locator())),
        BlocProvider<AuthBloc>(create:(_)  => AuthBloc(locator())),
        BlocProvider<UserBloc>(create:(_)  => UserBloc(locator())),
        BlocProvider<TaskBloc>(create:(_)  => TaskBloc(locator())),
        BlocProvider<SearchBloc>(create:(_)  => SearchBloc(locator())),
      ],
  child: child
);