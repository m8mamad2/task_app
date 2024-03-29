// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/extenstion/navigation_extension.dart';
import 'package:taskapp/src/core/sizes.dart';
import 'package:taskapp/src/core/styles.dart';
import 'package:taskapp/src/core/widget/bottom_navigation_widget.dart';
import 'package:taskapp/src/core/widget/error.dart';
import 'package:taskapp/src/view/data/model/auth_req_model.dart';
import 'package:taskapp/src/view/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:taskapp/src/view/presentation/screen/login_screen.dart';
import 'package:taskapp/src/view/presentation/widget/auth/auth_navigate_to_another_screen.dart';
import 'package:taskapp/src/view/presentation/widget/auth/auth_textfiedl_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}
class _SignupScreenState extends State<SignupScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  bool isHide = true;
  void onPressHide() => setState(() => isHide = !isHide);
  signupOnTap()async{

    SignupModel data = SignupModel(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim()
    );
    if(key.currentState!.validate()) context.read<AuthBloc>().add(SignupAuthEvent(data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor:kMainColor, ),
      body: Form(
        key: key,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kwidth(context)*0.06 ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            
                Text('SignUp in To Task 👋', style: TextStyle( color: Colors.white, fontSize: kwidth(context)*0.1, fontWeight: FontWeight.bold ),),
            
                authTextfiedlWidget( context, 'Name', nameController,'Jon Weak', false, isHide,'name',  onPressHide),
                authTextfiedlWidget( context, 'Email', emailController,'hello@gmail.com', false, isHide,'email',  onPressHide),
                authTextfiedlWidget(context,'Password', passwordController,'your password',true,isHide,'password',onPressHide),
                SizedBox(height: kheight(context)*0.05,),
                BlocConsumer<AuthBloc,AuthState>(
                    listener: (context, state)async {
                      if(state is FailAuthState) await errorBottomShet(context, state.error);
                      if(state is SuccessAuthState)await context.navigate(context, const BottomNavigationBarWidget());
                    },
                    builder: (context, state) {
                      if(state is InitialAuthState) return ElevatedButton( onPressed: signupOnTap,  style: authButtonStyle(context), child: const Text('login',style: TextStyle( color: Colors.black,fontWeight: FontWeight.w600 ),),);
                      if(state is LoadingAuthState)return loadingButton(context);
                      if(state is SuccessAuthState) return ElevatedButton( onPressed: signupOnTap,  style: authButtonStyle(context), child: const Text('login',style: TextStyle( color: Colors.black,fontWeight: FontWeight.w600 ),),);
                      if(state is FailAuthState)return failButton(context);
                      return Container();
                    },
                  ),
                authNavigateToAnotherScreen(context,'Already Have an account?','Login',const LoginScreen())
              ],
            ),
          ),
        ),
      ),
    );
  }
  loadingButton(BuildContext context) =>ElevatedButton( onPressed: (){}, style: authButtonStyle(context), child: const CircularProgressIndicator(),);
  failButton(BuildContext context) =>ElevatedButton( onPressed: signupOnTap, style: authButtonStyle(context,Colors.red), child: const Text('Fail ! Try Again',style: TextStyle(color: kFourthColor),),);

}