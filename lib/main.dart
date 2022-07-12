import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterchat/screens/buildprofile.dart';
import 'package:flutterchat/screens/chatscreen.dart';
import 'package:flutterchat/screens/log%20in.dart';
import 'package:flutterchat/screens/log in.dart';
import 'package:flutterchat/screens/phone_reg.dart';
import 'package:flutterchat/screens/sign%20up.dart';
import 'package:flutterchat/screens/userlistscreen.dart';
import 'package:flutterchat/screens/welcome_screen.dart';

void main() async{
WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id : (context)=>WelcomeScreen(),
        SignUp_Screen.id:(context)=>SignUp_Screen(),
        LogIn_Screen.id : (context)=>LogIn_Screen(),
        Chat_Screen.id : (context)=>Chat_Screen(),
        UserList_Screen.id : (context) =>UserList_Screen(),
        Phone_reg.id:(context)=>Phone_reg(),
        Profile.id :(context)=>Profile()
      },
    );
  }
}

