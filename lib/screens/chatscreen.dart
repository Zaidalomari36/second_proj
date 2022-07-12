import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutterchat/components/My_message.dart';
import 'package:flutterchat/components/myButton.dart';
import 'package:flutterchat/components/myTextfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Chat_Screen extends StatefulWidget {
  static String id="chat";
  final name;
  final email;
  final urlimg;
  Chat_Screen({this.name,this.email,this.urlimg});
  @override
  _Chat_ScreenState createState() => _Chat_ScreenState();
}

class _Chat_ScreenState extends State<Chat_Screen> {
  var msg=TextEditingController();
  var auth=FirebaseAuth.instance;
  var db=FirebaseFirestore.instance;
late File _imageFile;

pickImage()async{
  var picker= ImagePicker();
  var pikedfile=await picker.pickImage(source:ImageSource.gallery);
  setState(() {
    _imageFile=File(pikedfile!.path);
    upLoadImageToFirebase();
  });
}

upLoadImageToFirebase()async{

String filename= basename(_imageFile.path);
var storage=FirebaseStorage.instance.ref().child('images/$filename');
var uploadTask=storage.putFile(_imageFile);
var imgURL =await (await uploadTask).ref.getDownloadURL();
AddCollection("messages", '${widget.email}', imgURL, '2');
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xffBC0D0D),
      title: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                  widget.urlimg
              ),
            ),
            SizedBox(width: 20,),
            Text(
                "${widget.name}"
            ),
            ],
          ),

        Row(
          children: [
            Icon(Icons.phone,color: Colors.white,),

            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Icon(Icons.video_call,color: Colors.white,),
            )
          ],
        )

        ],
      )
        ),
      body: SafeArea(
        child: Column(

mainAxisAlignment: MainAxisAlignment.end,
         crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          StreamBuilder<QuerySnapshot>(

            stream: db.collection("messages").orderBy('time',descending: true).snapshots(),
            builder: (context,snapshot){
              if(snapshot.hasData)
                {
                  List <MyMessage>myWidgets=[];
                  for(var msg in snapshot.data!.docs)
                    {
                      var msgText = msg["text"];
                      var msgSender = msg["sender"];
                      var msgtype = msg["type"];
                      var My_message=MyMessage(
                        sender: msgSender,
                        msg_content: msgText,
                        type: msgtype,
                        isMe:auth.currentUser!.email==msgSender ,
                      );
                      myWidgets.add(My_message);
                    }
                 return Expanded(
                   child: Container(
                     decoration: BoxDecoration(
                       image: DecorationImage(
                         image:AssetImage("images/img.png"),
                         colorFilter: new ColorFilter.mode(
                             Colors.white.withOpacity(0.2),
                             BlendMode.dstATop
                         )
                       )
                     ),
                     child: Expanded(
                       child: ListView(
                         reverse: true,
                         children: myWidgets,
                         padding:EdgeInsets.all(10) ,
                       ),),
                   ),);
                }
              else return
                    Center(
                      child: CircularProgressIndicator(),
                    );},
          ),
           Row(
             children: [
               Expanded(
                 child:buildTextfield(TextInputType.emailAddress,
                     false,"Your message", msg),),
               IconButton(onPressed: (){
                 pickImage();
               }, icon: Icon(Icons.camera_alt,
                 color: Color(0xffBC0D0D),
                 size: 35,)),
               IconButton(onPressed:(){

             AddCollection("messages", '${widget.email}', msg.text, '1');

                 msg.clear();
} , icon: Icon(Icons.send,size: 30,color:Color(0xffBC0D0D) ,)),
             ],)
          ],),
      ),
    );

  }

  AddCollection(collec_name,receiver,msg_cont,type)
  {
    return            db.collection(collec_name).add(
        {
          'sender' :auth.currentUser!.email,
          'receiver' :receiver,
          'text':msg_cont,
          'time':DateTime.now().millisecondsSinceEpoch,
          'type':type
        });
  }
}
