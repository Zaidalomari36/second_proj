import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyMessage extends StatelessWidget {
final msg_content;
final sender;
final isMe;
final type;

MyMessage({this.msg_content,
  this.sender,
  this.isMe,
this.type,

});


  @override
  Widget build(BuildContext context) {
   if(type=="1")
   {
     return Padding(
       padding: EdgeInsets.all(8),
     child: Column(
       crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
       children: [
         Material(
           borderRadius: BorderRadius.circular(30),
           color:isMe ? Color(0xffBC0D0D):Color(0xff6D1C1C) ,
           child: Padding(
             padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
             child: Text('$msg_content',
                 style: TextStyle(fontSize: 12,color: Colors.white)),
           ),
         ),
         Text("${DateTime.now().hour} : ${DateTime.now().minute} PM",
           style:TextStyle(
             fontSize: 11,fontWeight: FontWeight.bold
           ) ,)
       ],
     ),
     );

   }
   else
     {
       return Padding(
         padding: EdgeInsets.all(8),
           child: Column(
    crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
children: [
Container(
  width: 120,
  height:120 ,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    image: DecorationImage(
      fit: BoxFit.fill,
      image: NetworkImage(msg_content)
    )
  ),
)
],
    )
       );
     }
  }
}
