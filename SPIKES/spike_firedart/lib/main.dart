import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spike_firedart/firebase_options.dart';
import 'package:spike_firedart/gauth_service.dart';
import 'package:firedart/firedart.dart';

const apiKey = 'AIzaSyAjVkDrHneMPPETPX_gAR799lGkppbTdHo';
const projectId = 'wayat-flutter';
const email = 'test@gmail.com';
const password = '12345678';
const desktopClientId =
    "887276025973-5t20nepvplh65ochp6pvrd5f76jidg1u.apps.googleusercontent.com";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Firestore.initialize(projectId);

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
                print('Print collection $groceryCollection');
              },
            ),
            ElevatedButton(
              child: const Text('Add to Collection'),
              onPressed: () {
                groceryCollection.add({"name": "Mango"});
                print('Add Mango item to collection');
              },
            ),
            ElevatedButton(
              child: const Text('Update Bananas item in Collection'),
              onPressed: () {
                groceryCollection
                    .document('T0T9XakXEi6UxA2yo4nj')
                    .update({'name': 'updated bananas'});
                print('Add Mango item to collection');
              },
            ),
          ],
        ),
      ),
    );
  }
}
