import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'main_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  String email = '';
  String password = '';
  String reEnterPassword = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Register'),
            TextField(
              onChanged: (newEmail) => email = newEmail,
              decoration: InputDecoration(hintText: 'Enter email'),
            ),
            TextField(
              onChanged: (newPassword) => password = newPassword,
              decoration: InputDecoration(hintText: 'Enter Password'),
            ),
            TextField(
              onChanged: (newReEnterPassword) =>
                  reEnterPassword = newReEnterPassword,
              decoration: InputDecoration(hintText: 'Re-Enter Password'),
            ),
            ElevatedButton(
                onPressed: () {
                  registerWithEmailAndPassword(context);
                },
                child: Text("Register")),
            ElevatedButton(
                onPressed: () {
                  signInWithGoogle(context);
                },
                child: Text("Sign in using Google")),
          ],
        ),
      ),
    );
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    await Firebase.initializeApp();
    await GoogleSignIn().signIn();
    var user = GoogleSignIn().currentUser;
    if (user != null) {
      debugPrint("Signed In");
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MainScreen();
      }));
    } else {
      debugPrint("Error in Sign in");
    }
  }

  Future<void> registerWithEmailAndPassword(BuildContext context) async {
    if (reEnterPassword == password && password != '' && email != '') {
      await Firebase.initializeApp();
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        user.sendEmailVerification();
        debugPrint("Registered!");
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MainScreen();
        }));
      } else {
        debugPrint("Error");
      }
    }
  }
}
