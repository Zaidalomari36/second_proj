import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterchat/components/myButton.dart';
import 'package:flutterchat/components/myTextfield.dart';
import 'package:flutterchat/screens/userlistscreen.dart';

enum MobileVerificationstate{
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE
}

class Phone_reg extends StatefulWidget {
  static String id="phone_reg";

  @override
  _Phone_regState createState() => _Phone_regState();
}

class _Phone_regState extends State<Phone_reg> {
  TextEditingController phone_number_cont=new TextEditingController();
  TextEditingController phone_OTP_cont=new TextEditingController();

  FirebaseAuth _auth=FirebaseAuth.instance;
  MobileVerificationstate currentstate=MobileVerificationstate.SHOW_MOBILE_FORM_STATE;
  late var verif_id;
  final GlobalKey<ScaffoldState> _scaffoldkey=GlobalKey();

  bool showloading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Sign by phone"),
      ),
      body:Container(
        child:showloading ? Center(child: CircularProgressIndicator(),) :currentstate==MobileVerificationstate.SHOW_MOBILE_FORM_STATE ?
        getMobileformWidget(context) : getOTPformWidget(context) ,
      )


    );

  }
  void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCreden) async{
    setState(() {
      showloading=true;
    });

  try {
    final autoCredential= await _auth.signInWithCredential(phoneAuthCreden);
setState(() {
  showloading=false;
});

if(autoCredential.user!=null)
    Navigator.pushNamed(context, UserList_Screen.id);

  } on FirebaseException catch (e) {
setState(() {
  showloading=false;
});
// ignore: deprecated_member_use
_scaffoldkey.currentState?.showSnackBar(SnackBar(
  content:Text(
    e.message.toString()
  ) ,
));
  }
  }

  getMobileformWidget(context){
    return
      Column(
        children: [
          Container(
            margin: EdgeInsets.all( 60),
            alignment: Alignment.center,
            child: Text("Phone Sign-up",style: TextStyle(
              fontWeight:FontWeight.bold,
              fontSize: 70,
              color: Color(0xffBC0D0D),
              fontFamily: 'Fuggles',
            ),),
          ),
          buildTextfield(TextInputType.phone, false, "Your number", phone_number_cont),
          buildButton(Color(0xff0AB146),()async{

            setState(() {
              showloading=true;
            });

            await _auth.verifyPhoneNumber(
              phoneNumber: phone_number_cont.text,
              verificationCompleted:(PhoneAuthCredential)async{
setState(() {
  showloading=false;
});
//signInWithPhoneAuthCredential(PhoneAuthCredential);
              } ,
              verificationFailed: (verificationFailed)async{
                setState(() {
                  showloading=false;
                });
                // ignore: deprecated_member_use
                _scaffoldkey.currentState!.showSnackBar(
                 SnackBar(content: Text(verificationFailed.message.toString()))
                );
              },

              codeSent:(String verificationId, _auth)async{
                setState(() {
                  showloading=false;
                  currentstate = MobileVerificationstate.SHOW_OTP_FORM_STATE;
                  verif_id=verificationId;
                });
              },

              codeAutoRetrievalTimeout: (verificationId){},

            );},"Verify", Colors.white)
        ],
      );
  }

  getOTPformWidget(context){
    return
      Column(
        children: [
          Container(
            margin: EdgeInsets.all( 60),
            alignment: Alignment.center,
            child: Text("Give the Code",style: TextStyle(
              fontWeight:FontWeight.bold,
              fontSize: 70,
              color: Color(0xffBC0D0D),
              fontFamily: 'Fuggles',
            ),),
          ),
          buildTextfield(TextInputType.phone, false, "OTP", phone_OTP_cont),
          buildButton(Color(0xff0AB146),()async{
            final phoneAuthcred=PhoneAuthProvider.credential(
                verificationId: verif_id, smsCode: phone_OTP_cont.text);
            signInWithPhoneAuthCredential(phoneAuthcred);
          },"Verify", Colors.white)
        ],
      );
  }
}


