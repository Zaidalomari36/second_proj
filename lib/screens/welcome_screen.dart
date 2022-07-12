import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterchat/components/myButton.dart';
import 'package:flutterchat/screens/log%20in.dart';
import 'package:flutterchat/screens/sign%20up.dart';
import 'package:flutterchat/screens/userlistscreen.dart';

class WelcomeScreen extends StatefulWidget {
static String id="welcome";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  getCurrentUser()async{
    var user=await FirebaseAuth.instance.currentUser;
    if(user!=null)
      Navigator.pushNamed(context, UserList_Screen.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(title:Text("Ask App"),
        backgroundColor:Color(0xff800020) ,),
      body:
      SingleChildScrollView(
      child:  Container(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image(image:AssetImage("images/img.png")

            ),
            buildButton(Color(0xffC70039),(){
              Navigator.pushNamed(context,LogIn_Screen.id);
            },"Log In",Colors.white),
            buildButton(Color(0xff800020),(){
              Navigator.pushNamed(context,SignUp_Screen.id);
            },"Sign Up",Colors.white),
          ],
        ),
        ),
      )
    );
  }
}
