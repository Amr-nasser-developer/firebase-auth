import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:softagirevisiontask/modules/layout/Home_Screen.dart';
import 'package:softagirevisiontask/modules/welcome/welcome_screen.dart';
import 'package:softagirevisiontask/shared/color.dart';
import 'package:softagirevisiontask/shared/componads.dart';
import 'package:softagirevisiontask/shared/remote/dio.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var widget;
   await initPref().then((value){
     if(getToken() != null && getToken().length >0){
      // print('wdyyyy');
       widget = HomeScreen();
     }else{
      // print('a7a yastaa');
       widget = WelecomeScreen();
     }
   });
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  var widget;
  MyApp(this.widget);
  @override
  Widget build(BuildContext context) {
    DioHelper();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: defaultColor,
          ),
        scaffoldBackgroundColor: Colors.grey[200]
      ),
      debugShowCheckedModeBanner: false,
      home: widget,
    );
  }
}

