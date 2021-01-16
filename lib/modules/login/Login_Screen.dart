import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softagirevisiontask/modules/forgot/ForgotPassword%20_%20Screen.dart';
import 'package:softagirevisiontask/modules/layout/Home_Screen.dart';
import 'package:softagirevisiontask/modules/login/cubit/cubit.dart';
import 'package:softagirevisiontask/modules/login/cubit/states.dart';
import 'package:softagirevisiontask/modules/signup/Signup_Screen.dart';
import 'package:softagirevisiontask/shared/componads.dart';
class loginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  String email;
  String password;
  loginScreen({this.email,this.password});
  @override
  Widget build(BuildContext context) {
    if(email != null && password != null){
      emailController.text = email;
      passwordController.text = password;
    }
    return BlocProvider(
      create: (BuildContext context)=> LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
          listener: (context , state){
              if(state is LoginLoading){
                buildProgress(
                  text: 'Please wait...',
                  context: context,
                  error: false
                );
              }
              if(state is LoginSuccess){
                Navigator.pop(context);
                setToken(state.token).then((value) {
                  if(value){
                    print('token was took');
                    finishNavigate(context, HomeScreen());
                  }else{
                   showToast(
                       text: 'token failed', error: true);
                  }
                });

              }
              if(state is LoginError){
                Navigator.pop(context);
                buildProgress(
                  context: context,
                  text: 'the email is incorrect',
                  error: true
                );
              }
          },
          builder: (context , state){
            return Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 80.0),
                        alignment: Alignment.topLeft,
                        child: defaultHeadText('Login'),
                      ),
                      SizedBox(height: 80.0,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center ,
                        children: [

                          SizedBox(height: 60.0,),
                          defaultFormText(
                            text: 'Email',
                            hint: 'amrnasser@gmail.com',
                            controller: emailController ,
                            type: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 15.0,),
                          defaultFormText(
                              text: 'Password',
                              hint: '*******',
                              controller: passwordController ,
                              type: TextInputType.visiblePassword,
                              obscure: true
                          ),
                          SizedBox(height: 60.0,),
                          defaultFlatButton(
                              text: 'login',
                              function: (){
                                if(emailController.text.isEmpty||passwordController.text.isEmpty){
                                  showToast(text: 'enter full data', error: true);
                                  return;
                                }
                                LoginCubit.get(context).Login(
                                  password: passwordController.text,
                                  email: emailController.text,
                                );
                              }
                          ),
                          SizedBox(height: 15.0,),
                          defaultFlatButton(
                              text: 'SignUp',
                              function: (){navigateTo(context, SignupScreen());}
                          ),
                          SizedBox(height: 20.0,),
                          InkWell(
                              onTap: (){navigateTo(context, ForgotScreen());},
                              child: defaultCaptionText('Forgot The Password ? ')
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
      )
    );
  }
}
