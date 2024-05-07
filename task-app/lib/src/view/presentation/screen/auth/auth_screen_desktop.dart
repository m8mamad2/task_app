// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/keys.dart';
import 'package:taskapp/src/core/sizes.dart';
import 'package:taskapp/src/view/data/model/auth_req_model.dart';
import 'package:taskapp/src/view/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:taskapp/src/view/presentation/widget/auth/login_design_widget.dart';
import 'package:taskapp/src/view/presentation/widget/auth/signup_design_widget.dart';

class LoginScreenDesktop extends StatefulWidget {
  const LoginScreenDesktop({super.key});

  @override
  State<LoginScreenDesktop> createState() => _LoginScreenDesktopState();
}
class _LoginScreenDesktopState extends State<LoginScreenDesktop> {

  bool isLoginScreen = true;

  final loginKey = Keys.loginDesktopKey;
  final signupKey = Keys.signupDesktopKey;

  final TextEditingController loginEamilController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  final TextEditingController signUpEamilController = TextEditingController();
  final TextEditingController signUpNameController = TextEditingController();
  final TextEditingController signUpPasswordController = TextEditingController();

  bool loginIsHide = true;
  bool signupIsHide = true;

  void loginOnPressHide() => setState(() =>  loginIsHide = !loginIsHide);
  void signupOnPressHide() => setState(() => signupIsHide= !signupIsHide);
  
  void changeAuthState ()=> setState(() => isLoginScreen = !isLoginScreen);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: isLoginScreen ? loginKey : signupKey,
        child: Row(
          children: [
        
            //*  Lottie File
            Expanded(
              child: Container(
                height: kheight(context),
                color: kSecondColor,
                child: Center(child: Lottie.asset('assets/lottie/login.json'),))),
        
        
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: kwidth(context)*0.05),
                child:  isLoginScreen 
                  ? loginDesignWidget( context, loginEamilController, loginPasswordController, loginIsHide, loginOnPressHide, loginOnTap,changeAuthState) 
                  : signupDesignWidget(context, signUpNameController, signUpEamilController, signUpPasswordController, signupIsHide, signupOnPressHide, signupOnTap,changeAuthState) 
                  
                ))
        
        
          ],
        ),
      ),
    );
  }

  Widget signUpScreen()=> Container();
 
  loginOnTap()async{
    LoginModel data = LoginModel( email: loginEamilController.text.trim(), password: loginPasswordController.text.trim() );
    if(loginKey.currentState!.validate()) context.read<AuthBloc>().add(LoginAuthEvent(data));
  }

  signupOnTap()async{
    SignupModel data = SignupModel( name: signUpNameController.text.trim(), email: signUpEamilController.text.trim(), password: signUpPasswordController.text.trim());
    if(signupKey.currentState!.validate()) context.read<AuthBloc>().add(SignupAuthEvent(data));
  }
    
}

