import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tb_jam/screens/notes/notes_screen.dart';
import 'package:tb_jam/utils/authentication.dart';

import '../../configurations/constants.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Bienvenido a',
            style: GoogleFonts.roboto(fontSize: 30),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'One',
              style:
                  GoogleFonts.roboto(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            Text(
              'Hand',
              style: GoogleFonts.roboto(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor),
            ),
          ]),
          const SizedBox(height: 60),
          FutureBuilder(
            future: Authentication.signInWithGoogle(context: context),
            builder: (context, snapshot) {
              /* if (!snapshot.hasError) {
                return const Text('Error initializing Firebase');
              } else */
              if (snapshot.connectionState == ConnectionState.done) {
                return const GoogleSignInButton();
              }
              return const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  kPrimaryColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return _isSigningIn
        ? const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                textStyle: const TextStyle(color: Colors.white)),
            onPressed: () async {
              setState(() {
                _isSigningIn = true;
              });

              User? user =
                  await Authentication.signInWithGoogle(context: context);

              setState(() {
                _isSigningIn = false;
              });

              if (user != null) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const NotesScreen(),
                  ),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Entrar con Google',
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
  }
}
