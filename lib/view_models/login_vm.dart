import 'package:flutter/material.dart';

class LoginVM{
 String imageNetText='https://i.pinimg.com/736x/f8/98/bf/f898bfb34a80f0784e1417c86a096e13.jpg';
 String login="Login";
 Widget myTextField(
     {required String text,
      sufixIcon,
      required TextEditingController tController,
      TextInputType tInpute = TextInputType.text,
      bool ispas = false,obscur}) {
  return Padding(
   padding: const EdgeInsets.symmetric(vertical: 15.0),
   child: TextFormField(
    textAlign: TextAlign.right,
    keyboardType: tInpute,
    controller: tController,
    validator: (value) {
     if (value!.isEmpty) {
      return ' $text null ';
     }
     return null;
    },
    obscureText: ispas ? obscur : false,
    decoration: InputDecoration(
        prefixIcon: ispas
            ? IconButton(
         onPressed: () {
           obscur = !obscur;
         },
         icon: obscur
             ? Icon(Icons.visibility_off)
             : Icon(Icons.visibility),
        )
            : null,
        suffixIcon: Icon(sufixIcon,
            color: Color.fromRGBO(235, 100, 64, 1), size: 20),
        hintText: text,
        hintStyle: TextStyle(
         fontFamily: 'Somar',
         fontSize: 15,
         fontWeight: FontWeight.w500,
         height: 0.2539,
         color: Color.fromRGBO(39, 39, 57, 1),
        )),
   ),
  );
 }

}