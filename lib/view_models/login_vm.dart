import 'package:flutter/material.dart';
import 'package:todotest/models/cubit/cubit.dart';
import 'package:todotest/repositories/user_data.dart';

import '../models/cach_helper.dart';

class LoginVM {
  LoginVM(context) {
    _cubit = MyCubit.get(context);
  }
  MyCubit _cubit = MyCubit();
  String imageNetText = 'assets/login.png';
  String title = "Task Manager App";
  String loginButton = "Login";
  loginSuccess(userData) {

    UserData.data.fetchData(userData);
    if(ChachHelper.sharedpreferences?.containsKey("userdata")==false) {
      ChachHelper.setDataList(key: "userdata", value: [
      UserData.data.id.toString(),
      UserData.data.username.toString(),
      UserData.data.firstName.toString(),
      UserData.data.lastName.toString(),
      UserData.data.token.toString(),
    ]);
    }
  }
  Widget myTextField(
      {required String text,
      suffixIcon,
      required TextEditingController tController,
      TextInputType tInput = TextInputType.text,
      bool isPass = false}) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        textAlign: TextAlign.start,
        keyboardType: tInput,
        controller: tController,
        validator: (value) {
          if (value!.isEmpty) {
            return ' $text null ';
          }
          return null;
        },
        obscureText: isPass ? _cubit.obSec : false,
        decoration: InputDecoration(
            suffixIcon: isPass
                ? IconButton(
                    onPressed: () {
                      _cubit.passHideShow();
                    },
                    icon: _cubit.obSec
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                  )
                : null,
            prefixIcon: Icon(suffixIcon,
                color: const Color.fromRGBO(32, 48, 57, 1), size: 20),
            hintText: text,
            hintStyle: const TextStyle(
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
