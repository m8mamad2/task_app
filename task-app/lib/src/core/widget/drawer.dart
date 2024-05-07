
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/images.dart';
import 'package:taskapp/src/core/sizes.dart';
import 'package:taskapp/src/view/data/model/user_model_localy.dart';
import 'package:taskapp/src/view/presentation/bloc/user_bloc/user_bloc.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> titles= ['change Name', 'Help','Logout','Delete Account',];
    final List<IconData> icons = [Icons.person_outline,Icons.help_outline,Icons.logout_outlined,Icons.delete_outline];
    
    return Drawer(
      surfaceTintColor: kMainColor,
      shadowColor: kMainColor,
      backgroundColor: kMainColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      child: BlocBuilder<UserBloc,UserState>(
        builder: (context, state) {
          if(state is LoadingUserState)return const CircularProgressIndicator();
          if(state is SucessUserState){
            UserModelLocaly user = state.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding:  EdgeInsets.only(top:kheight(context)*0.06,left: kwidth(context)*0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //! Image
                      SizedBox(
                        width: kwidth(context)*0.25,
                        height: kheight(context)*0.125,
                        child: CircleAvatar( 
                          radius: kwidth(context)*0.18,
                          backgroundImage: AssetImage(finalImage(user.profileImage ?? 3)),
                          backgroundColor: kMainColor,),
                      ),
                      //! Nmae
                      Padding(
                        padding: EdgeInsets.only(top: kheight(context)*0.015),
                        child: Text(user.name ?? 'User',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: kwidth(context)*0.05),),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.white38,),
                
                ListView.builder(
                      itemCount: 4,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => oneDrawerCardWidget( icons[index],  titles[index]))
              ],
            );
          }
          if(state is FailUserState)return Text(state.fail);
          return Container();
        },
      ),
    );
  }
}


Widget oneDrawerCardWidget(IconData icon,String title)=>Card(
  margin: const EdgeInsets.symmetric(vertical: 5),
  color: kMainColor,
  child: ListTile(
    hoverColor: Colors.white12,
    focusColor: Colors.white12,
    selectedColor: Colors.white12,
    leading: Icon(icon,color: kThiredColor,),
    title: Text(title,style: const TextStyle(color: kFourthColor),),
  ),
);