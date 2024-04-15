// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tp/componets/my_button.dart';
import 'package:tp/componets/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

String? myValidateEmailFct(String? value) {
  const pattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  final regex = RegExp(pattern);
  if (value!.isEmpty) {
    return "Email Can't be empty ";
  } else if (!regex.hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null;
}

String? myValidatePwdFct(String? value) {
  const pattern = r'^(?=.*[A-Z])(?=.*?[0-9])(?=.*?[ @#\&*~])';
  final regex = RegExp(pattern);
  if (value!.isEmpty) {
    return "Password Can't be empty ";
  } else if (!regex.hasMatch(value)) {
    return 'The password must be at least 8 characters \n and should contain at least one upper case, \n one digit, one special character among (@#\&*~)';
  }
  return null;
}

String? myValidateConfirmePwdFct(String? value, String? text) {
  if (value != text) {
    return 'not the same';
  }
  return null;
}

class SignUp extends StatelessWidget {
  GlobalKey<FormState> myFormState = GlobalKey<FormState>();
  TextEditingController _emailConroller = TextEditingController();
  TextEditingController _passwordConroller = TextEditingController();
  TextEditingController _ConfirmePasswordConroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Form(
            key: myFormState,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Create your account",
                  style: TextStyle(fontSize: 32),
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                    myHintText: "Username",
                    isObscure: false,
                    myController: TextEditingController(),
                    myIcon: const Icon(Icons.person)),
                const SizedBox(
                  height: 8,
                ),
                MyTextField(
                    myHintText: "Email",
                    isObscure: false,
                    myController: _emailConroller,
                    myIcon: const Icon(Icons.email),
                    myValidator: myValidateEmailFct),
                const SizedBox(
                  height: 8,
                ),
                MyTextField(
                  myHintText: "Password",
                  isObscure: false,
                  myController: _passwordConroller,
                  myIcon: const Icon(Icons.lock),
                  myValidator: myValidatePwdFct,
                ),
                const SizedBox(
                  height: 8,
                ),
                MyTextField(
                  myHintText: "Confirme Password",
                  isObscure: false,
                  myController: _ConfirmePasswordConroller,
                  myIcon: const Icon(Icons.lock),
                  myValidator: (value) => myValidateConfirmePwdFct(
                      value, _ConfirmePasswordConroller.text),
                ),
                const SizedBox(
                  height: 30,
                ),
                MyButton(
                    myButtonLabel: "SignUp",
                    MyOnpressedFct: () {
                      if (myFormState.currentState!.validate()) {
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: _passwordConroller.text.trim(),
                            password: _emailConroller.text.trim());
                        Navigator.pushNamed(context, 'Home_page');
                      } else {
                        print("Not Valide");
                      }
                    }),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'OR',
                  style: TextStyle(),
                ),
                const SizedBox(
                  height: 8,
                ),
                MyButton(
                    myButtonLabel: "Sign in with Google",
                    MyOnpressedFct: () {}),
                const SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: 14),
                    ),
                    MyTextButton(
                        myButtonlabel: "Login",
                        MyOnpressedFct: () {
                          Navigator.pushNamed(context, 'Login_Page');
                        })
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
