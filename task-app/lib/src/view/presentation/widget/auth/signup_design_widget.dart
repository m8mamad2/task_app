// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/src/core/responsive.dart';
import 'package:taskapp/src/core/sizes.dart';
import 'package:taskapp/src/core/styles.dart';
import 'package:taskapp/src/core/widget/bottomNavigationBarWidget/bottom_navigation_widget_mobile.dart';
import 'package:taskapp/src/core/widget/error.dart';
import 'package:taskapp/src/view/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:taskapp/src/view/presentation/widget/auth/auth_navigate_to_another_screen.dart';
import 'package:taskapp/src/view/presentation/widget/auth/auth_textfiedl_widget.dart';
import 'package:taskapp/src/view/presentation/widget/auth/login_button_widget.dart';

signupDesignWidget(
  BuildContext context,
  TextEditingController nameController,
  TextEditingController emailController,
  TextEditingController passwordController,
  bool isHide,
  VoidCallback onPressHide,
  VoidCallback actionOnTap,
  VoidCallback changeAuthState
   )=>Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.isLarge(context) ? kwidth(context)*0.02 : kwidth(context)*0.06 ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
            Text('SignUp in To Task 👋', style: TextStyle( color: Colors.white, fontSize:Responsive.isLarge(context) ? kwidth(context)*0.03 : kwidth(context)*0.1, fontWeight: FontWeight.bold ),),
        
            authTextfiedlWidget( context, 'Name', nameController,'Jon Weak', false, isHide,'name',  onPressHide),
            authTextfiedlWidget( context, 'Email', emailController,'hello@gmail.com', false, isHide,'email',  onPressHide),
            authTextfiedlWidget(context,'Password', passwordController,'your password',true,isHide,'password',onPressHide),
            SizedBox(height: kheight(context)*0.05,),
            BlocConsumer<AuthBloc,AuthState>(
                listener: (context, state)async {
                  if(state is FailAuthState) await errorDialog(context, state.error);
                  if(state is SuccessAuthState) await Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (context) => const BottomNavigationBarWidgetMobile()  ));
                },
                builder: (context, state) {
                  if(state is InitialAuthState) return ElevatedButton( onPressed: actionOnTap,  style: authButtonStyle(context), child: const Text('Signup',style: TextStyle( color: Colors.black,fontWeight: FontWeight.w600 ),),);
                  if(state is LoadingAuthState)return loadingButton(context);
                  if(state is SuccessAuthState) return ElevatedButton( onPressed: actionOnTap,  style: authButtonStyle(context), child: const Text('Signup',style: TextStyle( color: Colors.black,fontWeight: FontWeight.w600 ),),);
                  if(state is FailAuthState)return failButton(context,actionOnTap);
                  return Container();
                },
              ),
            authNavigateToAnotherScreen(context,'Already Have an account?','Login', changeAuthState)
          
          ],
        ),
      ),
    );

    