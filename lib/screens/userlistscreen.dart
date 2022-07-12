import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterchat/components/myusers.dart';
import 'package:flutterchat/screens/welcome_screen.dart';
import 'package:flutterchat/screens/chatscreen.dart';

class UserList_Screen extends StatefulWidget {
  static String id="userlist";
  @override
  _UserList_ScreenState createState() => _UserList_ScreenState();
}

class _UserList_ScreenState extends State<UserList_Screen> {
  var db=FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Color(0xffBC0D0D),
        title: Text("Your Friends"),
     ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: db.collection("Users").orderBy("name").snapshots(),
          builder:(context,snapshot) {
            var my_users;
                List<MyUsers>myusers=[];
                for(var user in snapshot.data!.docs)
                  {
                    var name1=user["name"];
                    var email1=user["email"];
                    var imgurl1=user["ProfileImage"];
                     my_users=MyUsers(
                      name: name1,
                      email: email1,
                       urlimg: imgurl1
                    );
                    myusers.add(my_users);                  }

                return Expanded(
                    child:
                    ListView.builder(
                   itemCount: myusers.length,
                      itemBuilder: (BuildContext context,int index)
                      {
                        return GestureDetector(
                          child:
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(60)),
                              boxShadow:[
                                BoxShadow(
                                  color: Colors.black38,
                                  blurRadius: 10.0
                                )
                              ]
                            ),
                            child: Card(
                         color: Colors.white,
                              margin:EdgeInsets.all(15) ,
                              child: Row(
                                children: [
                                 Padding(padding:EdgeInsets.all(10),
                                 child: CircleAvatar(
                                   radius: 35,
                                   backgroundImage:
                                   NetworkImage(
                                         myusers[index].urlimg
                                     ),

                                 ),
                                 ),
                                  Text(myusers[index].name,style: TextStyle(fontSize: 25
                                  ),) ,
                                ],
                              ),
                            ),
                          ),

                         onTap: (){

                            Navigator.push(context, MaterialPageRoute(builder: (context)
                            {
                              return Chat_Screen(name:myusers[index].name,
                              email:myusers[index].email ,
                              urlimg: myusers[index].urlimg,);
                            }
                            ));
                          },);
                      },)
                );},
        ),

      ),
      floatingActionButton: FloatingActionButton(
        child:Icon(Icons.logout) ,
        backgroundColor:Color(0xffBC0D0D) ,
        onPressed: (){
          var auth=FirebaseAuth.instance;
          auth.signOut();
          Navigator.pushNamed(context, WelcomeScreen.id);
        },
      ),
    );}
    createIconButton(onpress,icon)
  {
    return IconButton(onPressed: onpress, icon: icon);
  }
}
