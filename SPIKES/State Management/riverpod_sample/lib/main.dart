import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// A Counter example implemented with riverpod

void main() {
  runApp(
    // Adding ProviderScope enables Riverpod for the entire project
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Home());
  }
}

/// Providers are declared globally and specify how to create a state
final counterProvider = StateProvider((ref) => 0);

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              'The actual count is: ${ref.watch(counterProvider.state).state}')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${ref.watch(counterProvider.state).state}'),
            ElevatedButton(
              onPressed: (() {
                ref.read(counterProvider.state).state =
                    ref.read(counterProvider.state).state + 10;
              }),
              child: const Text(
                'Add 10',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // The read method is a utility to read a provider without listening to it
        onPressed: (() {
          ref.read(counterProvider.state).state =
              ref.read(counterProvider.state).state + 1;
        }),
        child: const Icon(Icons.add),
      ),
    );
  }
}
