// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tp/componets/my_button.dart';
import 'package:tp/componets/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> myFormState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Form(
            key: myFormState,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text("Welcome to my App",
                    style: TextStyle(color: Colors.black, fontSize: 26)),
                const SizedBox(
                  height: 20,
                ),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/chef.png'),
                  radius: 75,
                ),
                const SizedBox(
                  height: 75,
                ),
                MyTextField(
                  myHintText: "Email",
                  isObscure: false,
                  myController: _emailController,
                  myIcon: const Icon(Icons.person),
                ),
                const SizedBox(
                  height: 8,
                ),
                MyTextField(
                  myHintText: "Password",
                  isObscure: true,
                  myController: _passwordController,
                  myIcon: const Icon(Icons.lock),
                ),
                const SizedBox(
                  height: 20,
                ),
                MyButton(
                    myButtonLabel: "login",
                    MyOnpressedFct: () {
                      if (myFormState.currentState!.validate()) {
                        FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim());
                        //if (authstate)
                        //Navigator.pushNamed(context, 'Home_page');
                      } else {
                        print("Not Valide");
                      }
                    }),
                const SizedBox(
                  height: 100,
                ),
                MyTextButton(
                    myButtonlabel: "Forgot you're password?",
                    MyOnpressedFct: () {
                      FirebaseAuth.instance.sendPasswordResetEmail(
                          email: _emailController.text.trim());
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.black),
                    ),
                    MyTextButton(
                        myButtonlabel: "SignUp",
                        MyOnpressedFct: () {
                          Navigator.pushNamed(context, 'Sign_page');
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
