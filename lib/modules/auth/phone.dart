import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:softagirevisiontask/modules/layout/Home_Screen.dart';
import 'package:softagirevisiontask/shared/componads.dart';

class PhoneScreen extends StatefulWidget {
  @override
  _PhoneScreenState createState() => _PhoneScreenState();
}
class _PhoneScreenState extends State<PhoneScreen> {
  var phoneController = TextEditingController();
  var codeController = TextEditingController();
  bool isCode = false;
  String verCode = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Authentication'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            if (!isCode)
              defaultFormText(
                controller: phoneController,
                type: TextInputType.phone,
                hint: 'enter phone number',
                text: 'Phone',
              ),
            if (isCode)
              defaultFormText(
                controller: codeController,
                type: TextInputType.phone,
                hint: 'enter verification code',
                text: 'code',
              ),
            SizedBox(
              height: 40.0,
            ),
            defaultFlatButton(
              function: () {
                if (isCode) {
                  phoneAuthentication(codeController.text);
                  finishNavigate(context, HomeScreen());
                } else {
                  String phone = phoneController.text;
                  if (phone.isEmpty) {
                    showToast(
                      text: 'please enter a valid phone number',
                      error: true,
                    );
                    return;
                  }
                  sendCode(phone);
                }
              },
              Uppar: true,
              text: isCode ? 'start' : 'next',
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }

  void sendCode(String number) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2$number',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int resendToken) {
        isCode = true;
        verCode = verificationId;
        setState(() {});
        //navigateTo(context, VerificationScreen(verificationId),);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void phoneAuthentication(String code) async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: this.verCode, smsCode: code);
    await FirebaseAuth.instance
        .signInWithCredential(phoneAuthCredential)
        .then((value) {
      print(value.user.uid);
    }).catchError((e) {
      print(e.toString());
    });
  }
}
