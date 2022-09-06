import 'package:firebase_core/firebase_core.dart';
import 'package:phone_verification/verivication_dialog.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:phone_verification/phone_verification_page.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  FirebaseAuth auth = FirebaseAuth.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PhoneVerificationPage());
  }
}
