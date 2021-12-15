import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tb_jam/screens/deletedTask/deleted_task.dart';
import 'package:tb_jam/screens/labels/labels_screen.dart';
import 'package:tb_jam/screens/login/login_sreen.dart';
import 'package:tb_jam/screens/notes/notes_screen.dart';
import 'package:tb_jam/screens/pomodoro/pomodoro_screen.dart';
import 'package:tb_jam/screens/schedule/schedule_screen.dart';
import 'configurations/theme.dart';

Future<void> main() async {
  runApp(const MyApp());
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'T&B JAM',
      theme: theme(context),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', ''),
      ],
      home: const SignInScreen(),
    );
  }
}

/* import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tb_jam/datePicker/date_picker.dart';
import 'package:tb_jam/utils/authentication.dart';
import 'configurations/theme.dart';
import 'login/login_sreen.dart';

Future<void> main() async {
  runApp(const MyApp());
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(
      BuildContext
          context) /*  => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: */
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'T&B JAM',
      theme: theme(context),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', ''),
      ],
      // home: const SignInScreen(),
      home: const DatePicker(),
    );
  }
}
 */