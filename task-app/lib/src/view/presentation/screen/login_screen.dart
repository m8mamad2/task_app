
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
import 'package:taskapp/src/view/presentation/screen/signup_screen.dart';
import 'package:taskapp/src/view/presentation/widget/auth/auth_navigate_to_another_screen.dart';
import 'package:taskapp/src/view/presentation/widget/auth/auth_textfiedl_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  bool isHide = true;
  void onPressHide() => setState(() => isHide = !isHide);
  loginOnTap()async{
    LoginModel data = LoginModel(
      email: emailController.text.trim(),
      password: passwordController.text.trim()
    );

    if(key.currentState!.validate()) context.read<AuthBloc>().add(LoginAuthEvent(data));
    
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
                    
                Text('Login To Task', style: TextStyle( color: Colors.white, fontSize: kwidth(context)*0.1, fontWeight: FontWeight.bold ),),
                    
                authTextfiedlWidget( context, 'Email', emailController,'hello@gmail.com', false, isHide,'email',  onPressHide),
                authTextfiedlWidget(context,'Password', passwordController,'your password',true,isHide,'password',onPressHide),
                
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: kheight(context)*0.01),
                  child: TextButton( onPressed: (){},  child: const Text('Forgot Password ?',style: TextStyle( color: kThiredColor, ),)),
                ),
                
                BlocConsumer<AuthBloc,AuthState>(
                  listener: (context, state)async {
                    if(state is FailAuthState)await errorBottomShet(context, state.error);
                    if(state is SuccessAuthState)await context.navigate(context, const BottomNavigationBarWidget());
                  },
                  builder: (context, state) {
                    if(state is LoadingAuthState)return loadingButton(context);
                    if(state is InitialAuthState) return ElevatedButton(  onPressed: loginOnTap,  style: authButtonStyle(context), child: const Text('login',style: TextStyle( color: Colors.black,fontWeight: FontWeight.w600 ),),);
                    if(state is SuccessAuthState) return ElevatedButton(  onPressed: loginOnTap,  style: authButtonStyle(context), child: const Text('login',style: TextStyle( color: Colors.black,fontWeight: FontWeight.w600 ),),);
                    if(state is FailAuthState)return failButton(context);
                    return Container();
                  },
                ),
                
                authNavigateToAnotherScreen(context,'Dot\'n have Account?','Login',const SignupScreen())
              ],
            ),
          ),
        ),
      ),
    );
  }

  loadingButton(BuildContext context) =>ElevatedButton( onPressed: (){}, style: authButtonStyle(context), child: const CircularProgressIndicator(),);
  failButton(BuildContext context) =>ElevatedButton( onPressed: loginOnTap, style: authButtonStyle(context,Colors.red), child: const Text('Fail ! Try Again',style: TextStyle(color: kFourthColor),),);

}

