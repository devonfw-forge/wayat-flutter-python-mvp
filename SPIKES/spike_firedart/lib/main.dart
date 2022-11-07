import 'package:firedart/auth/user_gateway.dart';
import 'package:flutter/material.dart';
import 'package:firedart/firedart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spike_firedart/gauth_service.dart';

const apiKey = 'AIzaSyAjVkDrHneMPPETPX_gAR799lGkppbTdHo';
const projectId = 'wayat-flutter';
const email = 'test@gmail.com';
const password = '12345678';
const desktopClientId =
    "887276025973-5t20nepvplh65ochp6pvrd5f76jidg1u.apps.googleusercontent.com";

void main() {
  FirebaseAuth.initialize(apiKey, VolatileStore());
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
  CollectionReference groceryCollection =
      Firestore.instance.collection('groceries');

  late GoogleSignIn googleSignIn;
  final GoogleAuthService authService = GoogleAuthService();

  firedartSignIn() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    String token = '';
    if (auth.isSignedIn) {
    } else {
      await auth.signIn(email, password);
    }
    user = await auth.getUser();
    auth.signInState.listen((state) => print("Signed ${state ? "in" : "out"}"));
    token = await auth.tokenProvider.idToken;
    print(user);
    print(token);
  }

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
                firedartSignIn();
              },
            ),
          ],
        ),
      ),
    );
  }
}
