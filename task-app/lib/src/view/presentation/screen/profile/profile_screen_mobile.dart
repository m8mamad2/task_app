
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/src/core/bottom_shets.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/extenstion/navigation_extension.dart';
import 'package:taskapp/src/core/images.dart';
import 'package:taskapp/src/core/sizes.dart';
import 'package:taskapp/src/core/widget/error_widget.dart';
import 'package:taskapp/src/core/widget/shimmer/profile_screen_shimmer.dart';
import 'package:taskapp/src/view/data/model/user_model_localy.dart';
import 'package:taskapp/src/view/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:taskapp/src/view/presentation/screen/change_profile_image/change_profile_image_screen_mobile.dart';
import 'package:taskapp/src/view/presentation/screen/help_webview_screen.dart';
import 'package:taskapp/src/view/presentation/widget/profile/profile_one_card_widget.dart';


const String kLogoutText= 'Are you sure you want to log out of your Account? 💁';
const String kDeleteAccountText= 'Are you sure you want to Delete your Account?  🙅🏻';

class ProfileScreenMobile extends StatefulWidget {
  const ProfileScreenMobile({super.key});

  @override
  State<ProfileScreenMobile> createState() => _ProfileScreenMobileState();
}
class _ProfileScreenMobileState extends State<ProfileScreenMobile> {

  final List<bool> hasValue = [true,true,false,false,false];
  final List<String> titles = ['Name','Email','Help', 'Logout','Delete Account'];
  final List<IconData> icons = [Icons.person_outline,Icons.email_outlined,Icons.help_outline,Icons.logout_outlined,Icons.delete_outline];

  late List<VoidCallback> onTaps;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    onTaps= [
      () async => changeInfoBottomShet(context,'Change Name'),
      (){},
      () => context.navigate(context, const HelpWebviewScreen()),
      () async => await deleteBottomShet(context,false,()=>context.read<UserBloc>().add(LogoutUserEvent(context)),kLogoutText), 
      () async => await deleteBottomShet(context,true ,()=>context.read<UserBloc>().add(DeleteUserAccountEvent(context)),kDeleteAccountText)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: kheight(context)*0.1,),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kwidth(context)*0.045),
          child: BlocBuilder<UserBloc,UserState>(
            builder: (context, state) {
              if(state is LoadingUserState)return ProfileScreenMobileShimmer(context);
              if(state is SucessUserState){
                UserModelLocaly user = state.data!;
                return Column(
                  children: [
                    //! Image
                    SizedBox(
                      width: kwidth(context)*0.3,
                      height: kheight(context)*0.155,
                      child: Stack(
                        children: [
                          CircleAvatar( 
                            radius: kwidth(context)*0.18,
                            backgroundImage: AssetImage(finalImage(user.profileImage ?? 3)),
                            backgroundColor: kMainColor,),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: ()=> context.navigate(context, ChangeProfileImageScreenMobile( profileNumber:user.profileImage)),
                              child: CircleAvatar( 
                                radius: kwidth(context)*0.04,
                                backgroundColor: kThiredColor,
                                child: Icon(Icons.edit_outlined,size: kwidth(context)*0.05,),),
                            )),
                        ],
                      ),
                    ),
                    
                    //! Nmae
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: kheight(context)*0.015),
                      child: Text(user.name ?? 'User',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: kwidth(context)*0.05),),
                    ),
                    SizedBox(height: kheight(context)*0.02,),
                    ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => profileCardWidget(
                        context, 
                        icons[index], 
                        titles[index],
                        onTaps[index],
                        hasValue[index],
                        index == 0 
                          ? user.name 
                          : index == 1
                            ? user.email
                            :null,
                        // index == 4 ? true : false
                        ))
                  ],
                );
              }
              if(state is FailUserState)return errorWidget(context, state.fail, kheight(context)*0.4, kheight(context)*0.4,()=> context.read<UserBloc>().add(GetUserEvent()));
              return Container();
            },
          ),
        ),
      ),
    );
  }
}



final List<bool> hasValue = [true,true,false,false,false];
final List<String> titles = ['Name','Email','Help', 'Logout','Delete Account'];
final List<IconData> icons = [Icons.person_outline,Icons.email_outlined,Icons.help_outline,Icons.logout_outlined,Icons.delete_outline];
