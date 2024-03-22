import 'package:authentication/loginPage.dart';
import 'package:authentication/round_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class signupPage extends StatefulWidget {
  signupPage({super.key});

  @override
  State<signupPage> createState() {
    return _signupPageState();
  }
}

class _signupPageState extends State<signupPage> {
  final _formkey = GlobalKey<FormState>();
  final EmailController = TextEditingController();
  final PasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    EmailController.dispose();
    PasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Signup Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                      hintText: "Set Pasword",
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
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
            RoundButton("Sign up now", onValidate),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already Registered?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => loginPage(),
                      ),
                    );
                  },
                  child: const Text("Login Now"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onValidate() {
    if (_formkey.currentState!.validate()) {
      _auth.createUserWithEmailAndPassword(
            email: EmailController.text.toString(),
            password: PasswordController.text.toString(),
          )
          .then((value) {})
          .onError((error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString())),
        );
      });
    }
  }
}
