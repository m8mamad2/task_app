
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/keys.dart';
import 'package:taskapp/src/view/data/model/auth_req_model.dart';
import 'package:taskapp/src/view/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:taskapp/src/view/presentation/widget/auth/login_design_widget.dart';
import 'package:taskapp/src/view/presentation/widget/auth/signup_design_widget.dart';

class LoginScreenMobile extends StatefulWidget {
  const LoginScreenMobile({super.key});

  @override
  State<LoginScreenMobile> createState() => _LoginScreenMobileState();
}
class _LoginScreenMobileState extends State<LoginScreenMobile> {

  bool isLoginScreen = true;

  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  final TextEditingController signUpEmailController = TextEditingController();
  final TextEditingController signUpNameController = TextEditingController();
  final TextEditingController signUpPasswordController = TextEditingController();
  
  
  final loginKey = Keys.loginKey;
  final signupKey = Keys.signupKey;
  
  bool loginIsHide = true;
  bool signupIsHide = true;
  
  void loginOnPressHide() => setState(() => loginIsHide = !loginIsHide);
  void signupOnPressHide() => setState(() => signupIsHide = !signupIsHide);
  
  void changeAuthState ()=> setState(() => isLoginScreen = !isLoginScreen);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor:kMainColor, ),
      body: Form(
        key: isLoginScreen ? loginKey : signupKey,
        child: isLoginScreen 
          ? loginDesignWidget(context, loginEmailController, loginPasswordController, loginIsHide, loginOnPressHide, loginOnTap,changeAuthState)
          : signupDesignWidget(context, signUpNameController, signUpEmailController, signUpPasswordController, signupIsHide, signupOnPressHide, signupOnTap,changeAuthState)
      ),
    );
  }

  loginOnTap()async{
    LoginModel data = LoginModel( email:    loginEmailController.text.trim(), password: loginPasswordController.text.trim());
    if(loginKey.currentState!.validate()) context.read<AuthBloc>().add(LoginAuthEvent(data));
  }
  
  signupOnTap()async{
    SignupModel data = SignupModel( name: signUpNameController.text.trim(), email: signUpEmailController.text.trim(), password: signUpPasswordController.text.trim());
    if(signupKey.currentState!.validate()) context.read<AuthBloc>().add(SignupAuthEvent(data));
  }
    
}
