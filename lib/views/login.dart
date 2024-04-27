
import 'package:flutter/material.dart';
import 'package:todotest/view_models/login_vm.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool obscur = true;
  TextEditingController passwordController = TextEditingController(),
      phoneController = TextEditingController();
  GlobalKey<FormState> form = GlobalKey();
  bool wait = false;
  LoginVM _loginVM=LoginVM();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: form,
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Container(
                    width: double.infinity,
                    child: Image.network(_loginVM.imageNetText)),
                 Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _loginVM.login,
                      textAlign: TextAlign.center,
                      style:const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          fontFamily: "Somar",
                          letterSpacing: 0,
                          color: Color.fromRGBO(39, 39, 57, 1)),
                    ),
                  ],
                ),
             const SizedBox(height: 20),
               _loginVM.myTextField(
                    text: 'Email',
                    tController: phoneController,
                    tInpute: TextInputType.phone,
                    sufixIcon: Icons.call),

                _loginVM.myTextField(
                    text: 'Password',
                    tController: passwordController,
                    tInpute: TextInputType.visiblePassword,
                    sufixIcon: Icons.lock,
                    ispas: true,obscur: obscur),
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
                wait
                    ? Center(child: CircularProgressIndicator())
                    : MaterialButton(
                  onPressed: () {
                    if (form.currentState!.validate()) {
                      setState(() {
                        wait = true;
                      });
                    }
                  },
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    width: 346,
                    height: 53,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(39, 39, 57, 1),
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      'تسجيل الدخول',
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
      ),
    );
  }
}