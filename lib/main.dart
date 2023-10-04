import 'package:flutter/material.dart';
import 'package:service/user_credientials/info_form.dart';
import 'package:service/user_credientials/loginpage.dart';
import 'package:service/user_credientials/register_1.dart';

import 'Screens/Home_screen.dart';
import 'Widgets/Splash_Screen.dart';


void main() =>
    runApp(MaterialApp(
      // home: HomePage(mobileNumber: '',)
      //   home: SplashScreen(),
      home: LoginPage(),
    ));


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
