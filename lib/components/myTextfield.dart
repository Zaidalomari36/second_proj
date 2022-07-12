import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

buildTextfield(keyboardType,obtxt,hint,cntrl)
{
  return Padding(
      padding: EdgeInsets.all(8),
    child: TextField(
      controller: cntrl,
      keyboardType: keyboardType,
      obscureText: obtxt,
    decoration: InputDecoration(
      hintText: hint,
      contentPadding:EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(24)
        )
      ),
      enabledBorder:OutlineInputBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(24)
          ),
        borderSide: BorderSide(color: Colors.blue,width:3)
      ),
     /*   focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(24)
            ),
            borderSide: BorderSide(color: Colors.blue,width:3)
        ),*/
    ),
    ),
  );
}