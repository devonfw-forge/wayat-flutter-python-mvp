import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spike_firedart/env_model.dart';
import 'package:spike_firedart/gauth_service.dart';
import 'package:firedart/firedart.dart';
import 'dart:developer' as dev;

import 'package:spike_firedart/options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Env file should be loaded before Firebase initialization
  await EnvModel.loadEnvFile();

  await Firebase.initializeApp(
      name: EnvModel.FIREBASE_APP_NAME,
      options: CustomFirebaseOptions.currentPlatformOptions);

  Firestore.initialize(dotenv.get('PROJECT_ID'));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Cloud Firestore Windows',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoogleSignIn googleSignIn;
  final GoogleAuthService authService = GoogleAuthService();

  CollectionReference groceryCollection =
      Firestore.instance.collection('groceries');

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: const Text('SignIn with Google'),
              onPressed: () {
                authService.signIn();
              },
            ),
            ElevatedButton(
              child: const Text('Get Collection'),
              onPressed: () {
                groceryCollection.get();
                dev.log('Print collection $groceryCollection');
              },
            ),
            ElevatedButton(
              child: const Text('Add to Collection'),
              onPressed: () {
                groceryCollection.add({"name": "New added mango"});
                dev.log('Add Mango item to collection');
              },
            ),
            ElevatedButton(
              child: const Text('Update Bananas item in Collection'),
              onPressed: () {
                groceryCollection
                    .document('T0T9XakXEi6UxA2yo4nj')
                    .update({'name': 'Just updated bananas'});
                dev.log('Update Bananas item in Collection');
              },
            ),
          ],
        ),
      ),
    );
  }
}
