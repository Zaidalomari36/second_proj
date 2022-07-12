import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutterchat/components/myButton.dart';
import 'package:flutterchat/components/myTextfield.dart';
import 'package:flutterchat/screens/userlistscreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Profile extends StatefulWidget {
  static String id="profile";
  final email;
  Profile({this.email});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
 TextEditingController txt_name=TextEditingController();
   var profilePic=NetworkImage("https://i.pinimg.com/474x/04/f0/42/04f0421b45476cc63c3266a70a9de1b7--worlds-largest-mondo.jpg");
  var db=FirebaseFirestore.instance;
 late File _imageFile;
late var imgURL;
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
    imgURL =await (await uploadTask).ref.getDownloadURL();
setState(() {
  profilePic=NetworkImage(imgURL);
});
 }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Name & Photo"),
        backgroundColor: Color(0xffBC0D0D),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [

          Container(
          width: 150,
            height: 150,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: profilePic,
                  fit: BoxFit.fill,
                )
            ),
          ),
          IconButton(onPressed:()async{
           pickImage();
          } , icon: Icon(Icons.photo_album,color:Color(0xffBC0D0D) ,size: 30,)),
              buildTextfield(TextInputType.text, false,"Your Name", txt_name),
              buildButton(Color(0xffBC0D0D), ()async{
                db.collection("Users").add(
                  {
                    'name':txt_name.text,
                    'email': widget.email,
                    'ProfileImage':imgURL
                  }
                );
Navigator.pushNamed(context, UserList_Screen.id);
              }, "Go for Chat", Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}

