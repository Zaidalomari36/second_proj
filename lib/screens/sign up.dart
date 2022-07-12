import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterchat/components/myButton.dart';
import 'package:flutterchat/components/myTextfield.dart';
import 'package:flutterchat/screens/buildprofile.dart';
import 'package:flutterchat/screens/phone_reg.dart';
import 'package:flutterchat/screens/userlistscreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
class SignUp_Screen extends StatefulWidget {
  static String id="sign up";
  @override
  _SignUp_ScreenState createState() => _SignUp_ScreenState();
}

class _SignUp_ScreenState extends State<SignUp_Screen> {
  var email_ctrl=TextEditingController();
  var pass_ctrl=TextEditingController();
bool visbl=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar:AppBar(
          title:Text("Sign up"),
          backgroundColor:Color(0xffBC0D0D) ,),
body:
SingleChildScrollView(
child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    Container (
      height: 350,
      padding: EdgeInsets.only(bottom: 10.0),
      child: Image(image:
      AssetImage("images/signup.jpg")
      ),
    ),
     buildTextfield(TextInputType.emailAddress,false,"enter your email",email_ctrl),
    buildTextfield(TextInputType.text,true,"enter your password",pass_ctrl),
    
    buildButton(Color(0xffBC0D0D) , ()async{
      setState(() {
        visbl=true;
      });
      var auth=FirebaseAuth.instance;
      var newUser=await auth.createUserWithEmailAndPassword(
          email: email_ctrl.text, password: pass_ctrl.text);

      if(newUser!=null) {
        setState(() {
          visbl = false;
        });
        Navigator.push(context,MaterialPageRoute(builder: (context)
        {
          return Profile(email: email_ctrl.text,);
        }
        ));

      }
    }, "Add more info ", Colors.white),
    Visibility(
        visible: visbl,
        child:Center(
          child: CircularProgressIndicator(),
        ) ),
  ],
) ,
)
    );}


    buildIcons(col1,process,img)
  {
return  Padding(
  padding: const EdgeInsets.all(8.0),
  child: GestureDetector(
    onTapDown: (tap){
      setState(() {
       col1=Colors.grey.withOpacity(0.9);
      });
    },
    onTapUp: (tap){
      setState(() {
        col1=Colors.white;
      });
    },
    onTap: process,
    child: Container(
      width:50,height: 50,
      decoration: BoxDecoration(
          boxShadow:[BoxShadow(
            color:col1 ,
            spreadRadius: 5,
            blurRadius: 5,
            offset: Offset(0, 0),
          )],
          shape: BoxShape.circle
      ),
      child: CircleAvatar(
        radius:100 ,
        backgroundImage: AssetImage(img),
      ),),),
);
  }
}
