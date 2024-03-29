
import 'package:get_it/get_it.dart';
import 'package:taskapp/src/config/notification_setup.dart';
import 'package:taskapp/src/view/data/data_source/remote/auth_api_call.dart';
import 'package:taskapp/src/view/data/data_source/remote/task_api_call.dart';
import 'package:taskapp/src/view/data/data_source/remote/user_api_call.dart';
import 'package:taskapp/src/view/data/repo/auth_repo_body.dart';
import 'package:taskapp/src/view/data/repo/notif_repo_body.dart';
import 'package:taskapp/src/view/data/repo/task_repo_body.dart';
import 'package:taskapp/src/view/data/repo/user_repo_body.dart';
import 'package:taskapp/src/view/domain/repo/auth_repo_header.dart';
import 'package:taskapp/src/view/domain/repo/notif_repo_header.dart';
import 'package:taskapp/src/view/domain/repo/task_repo_header.dart';
import 'package:taskapp/src/view/domain/repo/user_repo_header.dart';
import 'package:taskapp/src/view/domain/usecase/auth_usecase.dart';
import 'package:taskapp/src/view/domain/usecase/notif_usecase.dart';
import 'package:taskapp/src/view/domain/usecase/task_usecase.dart';
import 'package:taskapp/src/view/domain/usecase/usre_usecase.dart';
import 'package:taskapp/src/view/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:taskapp/src/view/presentation/bloc/notif_bloc/notif_bloc.dart';
import 'package:taskapp/src/view/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:taskapp/src/view/presentation/bloc/task_bloc/task_bloc.dart';
import 'package:taskapp/src/view/presentation/bloc/user_bloc/user_bloc.dart';

final GetIt locator = GetIt.instance;

Future getItSetup() async {

  locator.registerSingleton<LocalNotificationSetup>(LocalNotificationSetup());

  locator.registerSingleton<NotifRepoHeader>(NotifRepoBody(locator()));
  locator.registerSingleton<NotifUseCase>(NotifUseCase(locator()));
  locator.registerSingleton<NotifBloc>(NotifBloc(locator()));

  locator.registerSingleton<AuthApiCall>(AuthApiCall());
  locator.registerSingleton<AuthRepoHeader>(AuthRepoBody(locator()));
  locator.registerSingleton<AuthUsecase>(AuthUsecase(locator()));
  locator.registerSingleton<AuthBloc>(AuthBloc(locator()));
  
  locator.registerSingleton<UserApiCall>(UserApiCall());
  locator.registerSingleton<UserRepoHeader>(UserRepoBody(locator()));
  locator.registerSingleton<UserUsecase>(UserUsecase(locator()));
  locator.registerSingleton<UserBloc>(UserBloc(locator()));
  
  locator.registerSingleton<TaskApiCall>(TaskApiCall());
  locator.registerSingleton<TaskRepoHeader>(TaskRepoBody(locator()));
  locator.registerSingleton<TaskUseCase>(TaskUseCase(locator()));
  locator.registerSingleton<TaskBloc>(TaskBloc(locator()));
  
  locator.registerSingleton<SearchBloc>(SearchBloc(locator()));
  
}