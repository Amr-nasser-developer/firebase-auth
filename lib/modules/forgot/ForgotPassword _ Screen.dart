import 'package:flutter/material.dart';
import 'package:softagirevisiontask/modules/login/Login_Screen.dart';
import 'package:softagirevisiontask/shared/componads.dart';

class ForgotScreen extends StatelessWidget {
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(top: 60.0),
              child: defaultHeadText('Forgot Password'),
            ),
            SizedBox(height: 200.0,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                defaultFormText(
                    text: 'Email',
                    hint: 'amrnasser@gmail.com',
                    controller: emailController,
                    type: TextInputType.emailAddress
               ),
                SizedBox(height: 200.0,),
                defaultFlatButton(
                  text: 'send resend code',
                  function: (){print('Sent');},
                ),
                SizedBox(height: 15.0,),
                defaultFlatButton(
                  text: 'Login',
                  function: (){navigateTo(context, loginScreen());}
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
