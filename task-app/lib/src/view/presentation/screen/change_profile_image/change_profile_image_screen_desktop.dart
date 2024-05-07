import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/extenstion/navigation_extension.dart';
import 'package:taskapp/src/core/images.dart';
import 'package:taskapp/src/core/sizes.dart';
import 'package:taskapp/src/view/presentation/bloc/user_bloc/user_bloc.dart';

class ChangeProfileImageScreenDesktop extends StatefulWidget {
  final int? profileNumber;
  const ChangeProfileImageScreenDesktop({super.key,required this.profileNumber});

  @override
  State<ChangeProfileImageScreenDesktop> createState() => _ChangeProfileImageScreenDesktopState();
}

class _ChangeProfileImageScreenDesktopState extends State<ChangeProfileImageScreenDesktop> {
  
  late int selected;
  @override
  void initState() {
    super.initState();
    selected = widget.profileNumber!;
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: kMainColor,
        shadowColor: kMainColor,
        surfaceTintColor: kMainColor,
        toolbarHeight: kheight(context)*0.1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: kThiredColor,),
          onPressed: () => context.navigateBack(context),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kwidth(context)*0.05),
            child: Text('save'),
            )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: kwidth(context)*0.05),
        child: Column(
          children: [
            //! Image
            CircleAvatar( 
              radius: kwidth(context)*0.06,
              backgroundImage: AssetImage(finalImage(selected)),
              backgroundColor: kMainColor,),
        
            Padding(
              padding:  EdgeInsets.only(top: kheight(context)*0.04,bottom: kheight(context)*0.03),
              child: const Text('Please Chosee a Image of Blow :',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 30),),
            ),
        
            GridView.builder(
              itemCount: 8,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 19,
                mainAxisExtent: 130,
                crossAxisCount: 3), 
              itemBuilder: (context, index) => InkWell(
                onTap: ()=>setState(()=> selected = index  ),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(kProfileImages[index])),
                    shape: BoxShape.circle,
                    border: Border.all(color: kThiredColor)
                  ),
                ),
              )),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(vertical:kheight(context)*0.02 ),
              child: BlocBuilder<UserBloc,UserState>(
                builder: (context, state) {
                  onTap()=>
                    context.read<UserBloc>().add(UpdateUserAvatarEvent(selected + 1, context));
        
                  if(state is LoadingUserState)return loadingButton(context);
                  if(state is InitialUserState)return ElevatedButton( onPressed: onTap, style: style(context, kThiredColor), child: const Text('save it',style: TextStyle(color: Colors.white),), );
                  if(state is SucessUserState)return  ElevatedButton( onPressed: onTap, style: style(context, kThiredColor), child: const Text('save it',style: TextStyle(color: Colors.white),), );
                  if(state is FailUserState)return failButton(context,onTap);
                  return Container();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  loadingButton(BuildContext context) =>ElevatedButton( onPressed: (){}, style: style(context,kThiredColor), child: const CircularProgressIndicator(),);
  failButton(BuildContext context,VoidCallback onTap) =>ElevatedButton( onPressed: onTap, style: style(context,Colors.red), child: const Text('Fail ! Try Again',style: TextStyle(color: kFourthColor),),);


}

ButtonStyle style(BuildContext context,Color color)=> ElevatedButton.styleFrom(
  backgroundColor: color,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  minimumSize: Size(kwidth(context), kheight(context)*0.06)
);