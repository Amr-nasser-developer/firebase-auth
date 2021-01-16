import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:softagirevisiontask/modules/auth/phone.dart';
import 'package:softagirevisiontask/modules/layout/Home_Screen.dart';
import 'package:softagirevisiontask/modules/login/Login_Screen.dart';
import 'package:softagirevisiontask/modules/signup/Signup_Screen.dart';
import 'package:softagirevisiontask/shared/color.dart';
import 'package:softagirevisiontask/shared/componads.dart';

class WelecomeScreen extends StatelessWidget {
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes:
    [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20.0,),
            Container(
              width: double.infinity,
              child:Image(image: AssetImage('assets/images/main_logo.png')),
            ),
            SizedBox(height: 40.0,),
            defaultFlatButton(
              text: 'Login',
              function: (){navigateTo(context, loginScreen());},
            ),
            SizedBox(height: 15.0,),
            defaultFlatButton(
              text: 'register',
              function: (){navigateTo(context, SignupScreen());},
            ),
            SizedBox(height: 15.0,),
            defaultCaptionText('Or Login With'),
            SizedBox(height: 15.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                    backgroundColor: defaultColor,
                    child: defaultImage('assets/images/facebook.png')
                ),
                SizedBox(width: 15.0,),
                GestureDetector(
                  onTap: (){
                    handleSignIn().then((value) => finishNavigate(context, HomeScreen()));
                  },
                  child: CircleAvatar(
                      backgroundColor: defaultColor,
                      child: defaultImage('assets/images/google.png')
                  ),
                ),
                SizedBox(width: 15.0,),
                CircleAvatar(
                    backgroundColor: defaultColor,
                    child: IconButton(icon: Icon(Icons.phone, color: Colors.white,),onPressed: (){
                      navigateTo(context,PhoneScreen());
                    },)
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> handleSignIn() async
  {
    await googleSignIn.signIn().then((value) async
    {
      print(value.email);
      print(value.displayName);
      print(value.photoUrl);

      GoogleSignInAuthentication googleSignInAuthentication = await value.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );


      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        print(value.user.uid);
      }).catchError((e)
      {
        print(e.toString());
      });

    }).catchError((e){
      print(e.toString());
    });
  }
}
