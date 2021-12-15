import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class OurUser {
  late String? uid;
  late String? email;
  late String? name;
  late DateTime? createdAt;

  OurUser({
    this.uid,
    this.email,
    this.name,
    this.createdAt,
  });
}

class OurDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(OurUser user) async {
    String retVal = 'error';
    try {
      _firestore.collection('users').doc(user.uid).set({
        'name': user.name,
        'email': user.email,
        'createdAt': DateTime.now(),
      });
    } catch (e) {
      print(e);
    }

    return retVal;
  }
}

class Authentication {
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    OurUser _user = OurUser();

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);
        user = userCredential.user;
        // ignore: empty_catches
      } catch (e) {}
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);
          if (userCredential.additionalUserInfo!.isNewUser) {
            _user.uid = userCredential.user!.uid;
            _user.email = userCredential.user!.email;
            _user.name = userCredential.user!.displayName;

            OurDatabase().createUser(_user);
          }

          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            // ...
          } else if (e.code == 'invalid-credential') {
            // ...
          }
        } catch (e) {
          // ...
        }
      }
    }

    return user;
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class GoogleSignInProvider extends ChangeNotifier {
//   final googleSignIn = GoogleSignIn();

//   GoogleSignInAccount? _user;

//   GoogleSignInAccount get user => _user!;

//   Future googleLogin() async {
//     final googleUser = await googleSignIn.signIn();
//     if (googleUser == null) return;
//     _user = googleUser;

//     final googleAuth = await googleUser.authentication;

//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     await FirebaseAuth.instance.signInWithCredential(credential);

//     notifyListeners();
//   }
// }
