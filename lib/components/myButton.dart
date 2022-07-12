import 'package:flutter/material.dart';

buildButton(mycolor,myfunction,mytext,textcol)
{
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Material(
      elevation: 5,
      color: mycolor,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        child:Text(mytext,style: TextStyle(
          fontSize: 18,
          color: textcol
        ),) ,
        onPressed: myfunction,
height: 40,


      ),
    ),
  );
}