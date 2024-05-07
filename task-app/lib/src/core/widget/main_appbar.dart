// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/extenstion/navigation_extension.dart';
import 'package:taskapp/src/core/images.dart';
import 'package:taskapp/src/core/keys.dart';
import 'package:taskapp/src/core/sizes.dart';
import 'package:taskapp/src/view/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:taskapp/src/view/presentation/screen/notif/notif_screen_mobile.dart';
import 'package:taskapp/src/view/presentation/screen/profile/profile_screen_mobile.dart';

// ignore: must_be_immutable
class MainAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  Size size;
  bool isHomeScreenMobile;
  MainAppBarWidget({
    Key? key,
    required this.size,
    required this.isHomeScreenMobile
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        foregroundColor: kMainColor,
        shadowColor: kMainColor,
        surfaceTintColor: kMainColor,
        toolbarHeight: kheight(context)*0.1,
        leading: isHomeScreenMobile ? IconButton(onPressed: ()=> Keys.bottomNavigationShet.currentState?.openDrawer(),icon: const Icon(Icons.menu,color: kFourthColor,),) : const SizedBox.shrink(),
        actions: [
          isHomeScreenMobile ? IconButton(onPressed: ()=>context.navigate(context, const NotifScreenMobile()),icon:const Icon(Icons.notifications),color: kFourthColor,) : const SizedBox.shrink(),
          BlocBuilder<UserBloc,UserState>(
            builder: (context, state) {
              if(state is LoadingUserState)return const CircularProgressIndicator(color: Colors.amber,);
              if(state is SucessUserState)return InkWell(onTap: ()=>context.navigate(context, const ProfileScreenMobile()),child: CircleAvatar(backgroundColor: kMainColor,backgroundImage: AssetImage(finalImage(state.data!.profileImage ?? 1)),radius: kwidth(context)*0.06));
              if(state is FailUserState)return const CircularProgressIndicator(color: Colors.red,);
              return const CircularProgressIndicator(color: Colors.purple,);
            },
          ),
          SizedBox(width: kwidth(context)*0.045,),
        ],
      );
  }
  
  @override
  Size get preferredSize => size;
}
