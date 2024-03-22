import 'dart:ffi';

import 'package:authentication/post_login.dart';
import 'package:authentication/round_btn.dart';
import 'package:authentication/signupPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class loginPage extends StatefulWidget {
  loginPage({super.key});

  @override
  State<loginPage> createState() {
    return _loginPageState();
  }
}

class _loginPageState extends State<loginPage> {
  final _formkey = GlobalKey<FormState>();
  final EmailController = TextEditingController();
  final PasswordController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    EmailController.dispose();
    PasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          automaticallyImplyLeading: false,
          title: const Text("Login Page"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors:[Colors.orange,Colors.blue,Colors.green],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight
                ).createShader(bounds),
                child:const  Text(
                  "PennyWise India",
                  style: TextStyle(fontSize: 24,color: Colors.white)
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.18,
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: EmailController,
                      decoration: const InputDecoration(
                          hintText: "Email",
                          helperText: "eg: ABC@xyz.com",
                          prefixIcon: Icon(Icons.email_outlined),
                          prefixIconColor: Colors.deepPurple),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Not a valid Email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: PasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Pasword",
                        helperText: "eg: ABC@xyz.com",
                        prefixIcon: Icon(Icons.enhanced_encryption_rounded),
                        prefixIconColor: Colors.deepPurple,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "password field is empty";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20)
                  ],
                ),
              ),
              RoundButton("Login Now", onValidate),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Not Registered?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => signupPage()),
                      );
                    },
                    child: const Text("Register Now"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void onValidate() {
    if (_formkey.currentState!.validate()) {
      auth
          .signInWithEmailAndPassword(
        email: EmailController.text.toString(),
        password: PasswordController.text.toString(),
      )
          .then((value) {
        String email = auth.currentUser!.email.toString();
        String name = auth.currentUser!.displayName.toString();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PostLogin(email, name),
          ),
        );
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      });
    }
  }
}
