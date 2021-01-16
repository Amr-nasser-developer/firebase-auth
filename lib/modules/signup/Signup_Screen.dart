import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softagirevisiontask/modules/cubit/cubit.dart';
import 'package:softagirevisiontask/modules/cubit/states.dart';
import 'package:softagirevisiontask/modules/layout/Home_Screen.dart';
import 'package:softagirevisiontask/modules/login/Login_Screen.dart';
import 'package:softagirevisiontask/shared/componads.dart';

class SignupScreen extends StatelessWidget {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> CounterCubit(),
      child: BlocConsumer<CounterCubit , CounterStates>(
        listener: (context , state){
          if(state is CounterLoading){
            buildProgress(
              context: context,
              text: 'Please wait until create...',
            );
            Navigator.pop(context);
          }
          if(state is CounterSuccess){
            finishNavigate(context, loginScreen(
                  email: emailController.text,
              password: passwordController.text,
            ));
          }
          if(state is CounterError){
            Navigator.pop(context);
            buildProgress(
              context: context,
              text: 'The email is already used'
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
                      padding: EdgeInsets.only(top: 60),
                      alignment: Alignment.topLeft,
                      child: defaultHeadText('SignUP'),
                    ),
                    SizedBox(height: 35,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        defaultFormText(
                            text: 'First Name',
                            hint: 'Amr',
                            controller: firstNameController,
                            type: TextInputType.name
                        ),
                        SizedBox(height: 15.0,),
                        defaultFormText(
                            text: 'Last Name',
                            hint: 'Nasser',
                            controller: lastNameController,
                            type: TextInputType.name
                        ),
                        SizedBox(height: 15.0,),
                        defaultFormText(
                            text: 'Email',
                            hint: 'amrnasser@gmail.com',
                            controller: emailController,
                            type: TextInputType.emailAddress
                        ),
                        SizedBox(height: 15.0,),
                        defaultFormText(
                            text: 'Password',
                            hint: '*****',
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            obscure: true
                        ),
                        SizedBox(height: 15.0,),
                        defaultFormText(
                            text: 'City',
                            hint: 'Cairo',
                            controller: cityController,
                            type: TextInputType.name
                        ),
                        SizedBox(height: 20.0,),
                        defaultFlatButton(
                            text: 'signUp',
                            function: (){
                              if(firstNameController.text.isEmpty||lastNameController.text.isEmpty||
                                  emailController.text.isEmpty||passwordController.text.isEmpty||
                              cityController.text.isEmpty){
                                showToast(text: 'Enter availd data', error: true);
                                return;
                              }
                              CounterCubit.get(context).register(
                                  first: firstNameController.text,
                                  last: lastNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  city: cityController.text,

                              );
                            }
                        ),
                        SizedBox(height: 15.0,),
                        defaultFlatButton(
                            text: 'login',
                            function: (){navigateTo(context, loginScreen());}
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
          },
      ),
    );
  }
}
