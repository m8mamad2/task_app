import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/src/core/responsive.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/responsive_chose/responsive_choses.dart';
import 'package:taskapp/src/core/sizes.dart';
import 'package:taskapp/src/core/utils/is_user_login.dart';
// import 'dart:html' as html;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}
class SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Responsive.isDesktop(context) || Responsive.isTablet(context)
            ? Expanded( flex: 2 , child: logoLottie, )
            : logoLottie,

          Container(
            alignment: Alignment.bottomCenter,
            margin: Responsive.isDesktop(context) || Responsive.isTablet(context)
              ? const EdgeInsets.only(bottom: 70)
              : EdgeInsets.only(top: kwidth(context)*0.2),
            child: FutureBuilder(
              future: internetChecker(), 
              builder: (context, snapshot) {
                switch(snapshot.connectionState){
                    case ConnectionState.none:
                    case ConnectionState.waiting:return const CircularProgressIndicator(color: kThiredColor,);
                    default: 
                      bool? isConnect = snapshot.data;
                      return Container(width: 100,height: 100,color: kMainColor,
                        child: isConnect! 
                          ? const SizedBox.shrink() 
                          : const Text('No Internet',style: TextStyle(color: Colors.red),),);
                }
              },),
          ),
        ],
      ),
    );
  }

  Widget logoLottie =  Center(child: Image.asset('assets/logo/T.gif', filterQuality: FilterQuality.high,));

  Future<bool> internetChecker()async{
      try {
        bool? hasInternet;

        if(kIsWeb){
          // hasInternet = html.window.navigator.onLine ?? false
        }
        else{
          final result = await InternetAddress.lookup('google.com');
          hasInternet =  result.isNotEmpty && result[0].rawAddress.isNotEmpty;
        }


        if(hasInternet ?? false){
          bool isUserLogedIn = await isUserLoggin();
          if(mounted){
           await Future.delayed(const Duration(seconds: 5),()=>
              Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (context) => isUserLogedIn ? bottomNavigationBarChoose() : loginResponsiveChoese() )));
          }
          return true;
        }
        else {
          return false;
        }
        
        
      } on SocketException catch (_) {
        return false;
      }
  }

}


