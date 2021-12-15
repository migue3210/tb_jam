import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tb_jam/screens/notes/notes_screen.dart';
import 'package:tb_jam/utils/authentication.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
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
                Colors.orange,
              ),
            );
          },
        ),
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
                primary: Colors.redAccent[100],
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
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
  }
}

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:provider/provider.dart';
// import 'package:tb_jam/datePicker/date_picker.dart';
// import 'package:tb_jam/utils/authentication.dart';

// class SignInScreen extends StatefulWidget {
//   const SignInScreen({Key? key}) : super(key: key);

//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//           stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return const Center(child: Text('Algo ha salido mal'));
//             } else {
//               return const Center(
//                 child: GoogleSignInButton(),
//                 // child: FutureBuilder(
//                 //   // future: Authentication.signInWithGoogle(context: context),
//                 //   builder: (context, snapshot) {
//                 //     /* if (!snapshot.hasError) {
//                 //       return const Text('Error initializing Firebase');
//                 //     } else */
//                 //     if (snapshot.connectionState == ConnectionState.done) {
//                 //       return const GoogleSignInButton();
//                 //     }
//                 //     return const CircularProgressIndicator(
//                 //       valueColor: AlwaysStoppedAnimation<Color>(
//                 //         Colors.orange,
//                 //       ),
//                 //     );
//                 //   },
//                 // ),
//               );
//             }
//           }),
//     );
//   }
// }

// class GoogleSignInButton extends StatefulWidget {
//   const GoogleSignInButton({Key? key}) : super(key: key);

//   @override
//   _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
// }

// class _GoogleSignInButtonState extends State<GoogleSignInButton> {
//   // bool _isSigningIn = false;

//   @override
//   Widget build(BuildContext context) {
//     return /* _isSigningIn
//         ? const CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
//           )
//         :  */
//         ElevatedButton(
//       style: ElevatedButton.styleFrom(
//           primary: Colors.redAccent[100],
//           textStyle: const TextStyle(color: Colors.white)),
//       onPressed: () {
//         final provider =
//             Provider.of<GoogleSignInProvider>(context, listen: false);

//         provider.googleLogin();
//       },
//       // onPressed: () async {
//       //   setState(() {
//       //     _isSigningIn = true;
//       //   });

//       //   User? user =
//       //       await Authentication.signInWithGoogle(context: context);

//       //   setState(() {
//       //     _isSigningIn = false;
//       //   });

//       //   if (user != null) {
//       //     Navigator.of(context).pushReplacement(
//       //       MaterialPageRoute(
//       //         builder: (context) => const DatePicker(),
//       //       ),
//       //     );
//       //   }
//       // },
//       child: const Padding(
//         padding: EdgeInsets.symmetric(vertical: 10),
//         child: Text(
//           'Sign in with Google',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }
// }
