import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:service/user_credientials/loginpage.dart';
import 'package:service/user_credientials/register_1.dart';
import 'Screens/Home_screen.dart';
import 'Widgets/Splash_Screen.dart';

void main() => runApp( GetMaterialApp(
  home: SplashScreen(),
));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Services',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Colors.blue, // Set your desired accent color here
      ),
      home: LoginPage(), // You can set the initial route here
    );
  }
}
