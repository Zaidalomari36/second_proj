import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutterchat/components/myButton.dart';
import 'package:flutterchat/components/myTextfield.dart';
import 'package:flutterchat/screens/phone_reg.dart';
import 'package:flutterchat/screens/userlistscreen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogIn_Screen extends StatefulWidget {
  static String id="log in ";
  @override
  _LogIn_ScreenState createState() => _LogIn_ScreenState();
}

class _LogIn_ScreenState extends State<LogIn_Screen> {
  var email_ctrl=TextEditingController();
  var pass_ctrl=TextEditingController();
  bool visbl=false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar:AppBar(title:Text("Log in"),
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
                AssetImage("images/log in.jpg")
                ),
              ),
              buildTextfield(TextInputType.emailAddress,false,"enter your email",email_ctrl),
              buildTextfield(TextInputType.text,true,"enter your password",pass_ctrl),

              buildButton(Color(0xffBC0D0D),
                      ()async{
                setState(() {
                  visbl=true;
                });
                var auth=FirebaseAuth.instance;
                var newUser=await auth.signInWithEmailAndPassword(
                    email: email_ctrl.text, password: pass_ctrl.text);

                if(newUser!=null) {
                  setState(() {
                    visbl = false;
                  });
                  Navigator.pushNamed(context, UserList_Screen.id);

                }
              }, "Log in", Colors.white),

              Visibility(
                  visible: visbl,
                  child:Center(
                    child: CircularProgressIndicator(),
                  ) ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("or with :",style: TextStyle(
                        fontSize: 50,
                        fontFamily: 'Fuggles',
                        fontWeight: FontWeight.bold,
                        color: Color(0xffBC0D0D)
                    ),),
                  ),
                  SizedBox(
                    width: 20,
                  ),

                  buildIcons(Colors.white, ()async{
                    GoogleSignIn _googleSignIn=GoogleSignIn(scopes: ['email']);
                    var result = await _googleSignIn.signIn();
                    if(result!=null)
                      Navigator.pushNamed(context,UserList_Screen.id);
                    print(result!.displayName);
                  },"images/google.png"),

                  buildIcons(Colors.white,
                          ()async{
                        final LoginResult result=await FacebookAuth.instance.login();
                        if(result.status==LoginStatus.success)
                        {
                          final AccessToken accesstoken=result.accessToken!;
                          Navigator.pushNamed(context,UserList_Screen.id);
                        }
                      },"images/Facebook.png"),

                  Padding(
                    padding:EdgeInsets.all(8),
                    child: FloatingActionButton(
                      onPressed: () { Navigator.pushNamed(context,Phone_reg.id); },
                      child: Icon(Icons.phone),
                    ),
                  )
                ],),
            ],

          ) ,
        )


    );

  }
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
