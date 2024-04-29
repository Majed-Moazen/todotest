import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todotest/models/cubit/cubit.dart';
import 'package:todotest/models/cubit/statues.dart';
import 'package:todotest/view_models/login_vm.dart';

import '../main.dart';
import '../repositories/api.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {
  TextEditingController passwordController = TextEditingController(text:'0lelplR' ),
      userNameController = TextEditingController(text: 'kminchelle');
  GlobalKey<FormState> form = GlobalKey();
  bool wait = false;
  late LoginVM _loginVM;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyCubit, classState>(
      builder: (BuildContext c, s) {
        _loginVM = LoginVM(c);

      return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Form(
              key: form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: MyApp.height(7),
                  ),
                  Container(
                      width: double.infinity,
                      child: Image.asset(_loginVM.imageNetText),height: MyApp.height(25),),
                  Text(
                    _loginVM.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                        fontFamily: "Somar",
                        color: Color.fromRGBO(39, 39, 57, 1)),
                  ),
                  SizedBox(
                    height: MyApp.height(7),
                  ),
                  _loginVM.myTextField(
                      text: 'UserName',
                      tController: userNameController,
                      tInput: TextInputType.name,
                      suffixIcon: Icons.email),
                  _loginVM.myTextField(
                    text: 'Password',
                    tController: passwordController,
                    tInput: TextInputType.visiblePassword,
                    suffixIcon: Icons.lock,
                    isPass: true,
                  ),
                  // TextButton(
                  //     onPressed: () {},
                  //     child: Text(
                  //       'هل نسيت كلمة السر؟',
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.w700,
                  //         fontSize: 13,
                  //         fontFamily: 'Somar',
                  //         height: 0.1321,
                  //         color: Color.fromRGBO(39, 39, 57, 1),
                  //       ),
                  //     )),
                  SizedBox(height: MyApp.height(10)),
                  wait
                      ? Center(child: CircularProgressIndicator())
                      : MaterialButton(
                          onPressed: () {
                            if (form.currentState!.validate()) {
                              setState(() {
                                wait = true;
                                API.post('auth/login', {
                                  "username": userNameController.text,
                                  "password": passwordController.text,
                                  "expiresInMins": "30",
                                }).then((value) {
                                  setState(() {
                                    wait = false;
                                    _loginVM.loginSuccess(value!.data);
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));

                                  });
                                }).catchError((e) {
                                  setState(() {
                                    wait = false;
                                  });
                                });
                              });
                            }
                          },
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            width: MyApp.width(40),
                            height: 53,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(39, 39, 57, 1),
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              _loginVM.loginButton,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                fontFamily: "Somar",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (BuildContext c, s) {},
    );
  }
}
