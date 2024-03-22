import 'package:authentication/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostLogin extends StatelessWidget {
  PostLogin(this.email, this.user, {super.key});

  final auth = FirebaseAuth.instance;
  final String email;
  final String user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
        actions: [
          IconButton(
              onPressed: () {signout(context);},
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Email: $email"),
          ],
        ),
      ),
    );
  }

  void signout(context){
    auth.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context)=> loginPage()));
  }
}
