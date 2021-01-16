import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:softagirevisiontask/modules/welcome/welcome_screen.dart';
import 'package:softagirevisiontask/shared/componads.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(15.0),
            child : Row(
              children: [
               defaultAppBarIcons()
              ],
            ),
           ),
            SizedBox(height: 10.0,),
            Container(
              padding: EdgeInsets.only(left: 15.0),
              alignment: Alignment.topLeft,
              child: defaultHeadText('Settings'),
            ),
            SizedBox(height: 30,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                defaultDetailsText('Account Settings'),
                SizedBox(height: 10.0,),
                defaultBottomForm(text: 'Account Security'),
                SizedBox(height: 1,),
                defaultBottomForm(text: 'Email Notifications'),
                SizedBox(height: 1,),
                defaultBottomForm(text: 'Push Notifications'),
              ],
            ),
            SizedBox(height: 55.0,),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Container(
                alignment: Alignment.topLeft,
                  child: defaultDetailsText('support')),
            ),
            SizedBox(height: 20,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                defaultBottomForm(text: 'About App' ),
                SizedBox(height: 1,),
                defaultBottomForm(text: 'Frequently asked questions'),
                SizedBox(height: 1,),
                defaultBottomForm(text: 'Contact Us'),
                SizedBox(height: 1,),
                defaultBottomForm(text: 'Log Out', function: () {
                  deleteToken().then((value) => finishNavigate(context, WelecomeScreen()));
                })
              ],
            ),
          ],
        ),
      ),
    );
  }
}