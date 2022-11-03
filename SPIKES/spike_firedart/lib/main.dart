import 'package:flutter/material.dart';
import 'package:firedart/firedart.dart';

const apiKey = 'AIzaSyAjVkDrHneMPPETPX_gAR799lGkppbTdHo';
const projectId = 'wayat-flutter';

void main() {
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
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              child: const Text('List Groceries'),
              onPressed: () async {
                final groceries = await groceryCollection.get();

                print(groceries);
              },
            ),
            ElevatedButton(
              child: const Text('Add Grocery Item'),
              onPressed: () async {
                await groceryCollection.add({
                  'fruit': 'bananas',
                });
                print("Add item button pressed.");
              },
            ),
            ElevatedButton(
              child: const Text('Edit Grocery Item'),
              onPressed: () async {
                await groceryCollection
                    .document('x3qQrSLNKeqvbhjg6O1P')
                    .update({
                  'fruit': 'Apples!',
                });
                print('Edit Grocery item button pressed.');
              },
            ),
            ElevatedButton(
              child: const Text('Delete Grocery Item'),
              onPressed: () async {
                await groceryCollection
                    .document('x3qQrSLNKeqvbhjg6O1P')
                    .delete();

                print('Delete Grocery Item Button Pressed.');
              },
            ),
          ],
        ),
      ),
    );
  }
}
