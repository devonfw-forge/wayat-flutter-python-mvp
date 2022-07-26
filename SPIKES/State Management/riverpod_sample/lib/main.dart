import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// global declaration of provider
import 'package:riverpod_sample/providers.dart';
import 'package:riverpod_sample/central_widget.dart';
import 'package:riverpod_sample/logger.dart';

// A Counter example implemented with riverpod
void main() {
  runApp(
    // Adding ProviderScope enables Riverpod for the entire project
    ProviderScope(observers: [LoggerTest()], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Home());
  }
}

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'The actual count is aprox ${ref.watch(counterProvider.select((value) => value ~/ 10))} times 10'),
      ),
      body: const CentralWidget(),
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
