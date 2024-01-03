import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  void signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: TextButton(
        child: const Text('Sign in with Google'),
        onPressed: () async {
          signInWithGoogle();
        },
      ),
    ));
  }
}
