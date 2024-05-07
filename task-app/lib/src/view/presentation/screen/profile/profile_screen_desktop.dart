
import 'dart:developer';
import 'dart:io' as IO;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/src/core/bottom_shets.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/extenstion/navigation_extension.dart';
import 'package:taskapp/src/core/images.dart';
import 'package:taskapp/src/core/keys.dart';
import 'package:taskapp/src/core/sizes.dart';
import 'package:taskapp/src/core/styles.dart';
import 'package:taskapp/src/core/widget/error_widget.dart';
import 'package:taskapp/src/core/widget/shimmer/profile_screen_shimmer.dart';
import 'package:taskapp/src/core/widget/textfiedls.dart';
import 'package:taskapp/src/view/data/model/user_model_localy.dart';
import 'package:taskapp/src/view/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:taskapp/src/view/presentation/screen/change_profile_image/change_profile_image_screen_desktop.dart';
import 'package:taskapp/src/view/presentation/screen/change_profile_image/change_profile_image_screen_mobile.dart';
import 'package:taskapp/src/view/presentation/screen/help_webview_screen.dart';
import 'package:taskapp/src/view/presentation/widget/profile/profile_one_card_widget.dart';
import 'package:url_launcher/url_launcher.dart';


const String kLogoutText= 'Are you sure you want to log out of your Account? 💁';
const String kDeleteAccountText= 'Are you sure you want to Delete your Account?  🙅🏻';

class ProfileScreenDesktop extends StatefulWidget {
  const ProfileScreenDesktop({super.key});

  @override
  State<ProfileScreenDesktop> createState() => _ProfileScreenDesktopState();
}
class _ProfileScreenDesktopState extends State<ProfileScreenDesktop> {

  final List<bool> hasValue = [true,true,false,false,false];
  final List<String> titles = ['Name','Email','Help', 'Logout','Delete Account'];
  final List<IconData> icons = [Icons.person_outline,Icons.email_outlined,Icons.help_outline,Icons.logout_outlined,Icons.delete_outline];

  late List<VoidCallback> onTaps;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    onTaps= [
      () async => changeInfoDialog(context,'Change Name'),
      (){},
      kIsWeb 
        ? ()async{ if (!await launchUrl(parseUri)) throw Exception('Could not launch $parseUri'); }
        : IO.Platform.isAndroid 
            ? () => context.navigate(context, const HelpWebviewScreen())
            : ()async{
                if (!await launchUrl(parseUri)) throw Exception('Could not launch $parseUri');
              },
      () async => await deleteDialog(context,false,()=>context.read<UserBloc>().add(LogoutUserEvent(context)),kLogoutText), 
      () async => await deleteDialog(context,true ,()=>context.read<UserBloc>().add(DeleteUserAccountEvent(context)),kDeleteAccountText)
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
                    Row(
                      children: [
                        //! Image
                        CircleAvatar( 
                          radius: kwidth(context)*0.05,
                          backgroundImage: AssetImage(finalImage(user.profileImage ?? 3)),
                          backgroundColor: kMainColor,),

                        const SizedBox(width: 20,),

                        //! Nmae
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: kheight(context)*0.015),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user.name ?? 'User',style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 25),),
                              Text(user.email ?? 'User@gmail.com',style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w200,fontSize: 18),),
                            ],
                          ),
                        ),
                        
                        const Spacer(),
                        
                        InkWell(
                          onTap: () => context.navigate(context, ChangeProfileImageScreenDesktop(profileNumber: user.profileImage)),
                          child: Container(
                            decoration: BoxDecoration(
                              color: kMainColor,
                              border: Border.all(color: kFourthColor,width: 1),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text('Edit Profile Image',style: TextStyle(color: kFourthColor),)),
                          ),
                        )
                        
                      ],
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
              if(state is FailUserState)return errorWidget(context, state.fail, kheight(context)*0.4, kheight(context)*0.4,(){});
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


Future changeInfoDialog(BuildContext context,String lable) async {
  
  final key = Keys.changeInfoBottomShetKey;
  final TextEditingController controller = TextEditingController();

  loadingButton(BuildContext context) =>ElevatedButton( onPressed: (){}, style: authButtonStyle(context,kThiredColor), child: const CircularProgressIndicator(),);
  failButton(BuildContext context) =>ElevatedButton( onPressed: ()=>context.read<UserBloc>().add(UpdateUserNameEvent(controller.text.trim(),context)), style: authButtonStyle(context,kRedColor), child: const Text('Fail ! Try Again',style: TextStyle(color: kFourthColor),),);

  return await showDialog(
    context: context, 
    builder: (context) {
      return AlertDialog(
        backgroundColor: kMainColor,
        shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all( Radius.circular(20)) ),
        content: Container(
          width: kwidth(context)*0.4,
          height: kheight(context)*0.27,
          decoration: const  BoxDecoration(
            border: Border(top: BorderSide(color: kThiredColor)),
            color: kMainColor,
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Form(
            key: key,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kwidth(context)*0.04),
              child: Column(
                children: [
                  bottomSheTextFiedlWidgetDesktop(context,lable,'' ,controller,false,null,true),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: kheight(context)*0.03),
                    child: BlocBuilder<UserBloc,UserState>(
                      builder: (context, state) {
                        onTap()=>
                          context.read<UserBloc>().add(UpdateUserNameEvent(controller.text.trim(),context));
                        
                        
                        if(state is LoadingUserState) return loadingButton(context);
                        if(state is InitialUserState) return ElevatedButton( onPressed: onTap, style: authButtonStyleDesktop(context,kThiredColor), child: Text('Ok',style: changeInfoBottomShetTextStyleDesktop(context),),);
                        if(state is SucessUserState)  return ElevatedButton( onPressed: onTap, style: authButtonStyleDesktop(context,kThiredColor), child: Text('Ok',style: changeInfoBottomShetTextStyleDesktop(context),),);
                        if(state is FailUserState)    return failButton(context);
                        return Container();
                      },
                    ),
                  )
                ],
              ),
            )),
        ),
      );
    },);
}

Future deleteDialog(BuildContext context,bool isDeleteAcoount,VoidCallback onTap,String title) async {
  

  loadingButton(BuildContext context) =>ElevatedButton( onPressed: (){}, style: deleteButtonStyle(context,), child: const CircularProgressIndicator(),);
  failButton(BuildContext context)    => ElevatedButton( onPressed: (){}, style: deleteButtonStyle(context,), child: const Text('Fail ! Try Again',style: TextStyle(color: Colors.white),),);


  return await showDialog(
    context: context, 
    builder: (context) {
      return AlertDialog(
        backgroundColor: kSecondColor,
        shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all( Radius.circular(20)) ),
        
        content: Container(
          width:  kwidth(context)*0.4,
          height: kheight(context)*0.3 ,
          decoration: const  BoxDecoration(
            border: Border(top: BorderSide(color: kThiredColor)),
            color: kMainColor,
            borderRadius: BorderRadius.all( Radius.circular(20))
          ),
          
          child: Form(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kwidth(context)*0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isDeleteAcoount
                    ? Container(
                        margin: const EdgeInsets.only(top: 9),
                        child: Icon(Icons.delete_forever_outlined,color: kRedColor,size: kwidth(context)*0.04))
                    : const SizedBox.shrink(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: kheight(context)*0.03),
                    child: Text(title,
                      style: const TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w600),)),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: kheight(context)*0.03),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: ()=> context.navigateBack(context), 
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              minimumSize: Size(kwidth(context)*0.43, kheight(context)*0.055),
                              backgroundColor: kThiredColor,
                              shape: RoundedRectangleBorder(
                                // side: const BorderSide(color: kFourthColor),
                                borderRadius: BorderRadius.circular(6),
                              )
                            ),
                            child: Text('Cancel',style: TextStyle(color: kFourthColor),)),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: BlocBuilder<UserBloc,UserState>(
                            builder: (context, state) {
                              if(state is LoadingUserState) return loadingButton(context);
                              if(state is InitialUserState) return ElevatedButton( onPressed: onTap, style: deleteButtonStyle(context), child: Text('Ok',style: deleteButtonStyleTextStyleDesktop(context),),);
                              if(state is SucessUserState)  return ElevatedButton( onPressed: onTap, style: deleteButtonStyle(context), child: Text('Ok',style: deleteButtonStyleTextStyleDesktop(context),),);
                              if(state is FailUserState)    return failButton(context);
                              return Container();
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
        ),
      );
    },);

}
