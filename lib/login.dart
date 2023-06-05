import 'package:demo_app/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Login'),
            TextField(
              onChanged: (newEmail) => email = newEmail,
              decoration: InputDecoration(hintText: 'Enter Email:'),
            ),
            TextField(
              onChanged: (newPassword) => password = newPassword,
              decoration: InputDecoration(hintText: 'Enter Password:'),
            ),
            ElevatedButton(
                onPressed: () {
                  signInWithEP();
                },
                child: Text('Login')),
            ElevatedButton(
                onPressed: () {
                  signInWithGoogle(context);
                },
                child: Text('Sign In With Google')),
          ],
        ),
      ),
    );
  }

  Future<void> signInWithEP() async {
    await Firebase.initializeApp();
    var firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    User? user = firebaseAuth.currentUser;
    if (user != null) {
      debugPrint("Done");
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MainScreen();
      }));
    } else {
      debugPrint("Unable to sign in");
    }
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
}
