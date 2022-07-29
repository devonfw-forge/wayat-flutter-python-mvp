import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/providers.dart';

class CentralWidget extends StatelessWidget {
  const CentralWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Using two providers of the same type
          Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return Text(
                '${ref.watch(firstStringProvider)} ${ref.watch(secondStringProvider)}');
          }),
          Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return ref.watch(userProvider).when(data: (String value) {
              return Text(value);
            }, error: (Object error, StackTrace? trace) {
              return const Text("Error");
            }, loading: () {
              return const CircularProgressIndicator();
            });
          }),
          // Using consumers instead of ConsumerWidget
          Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return Text('${ref.watch(counterProvider.state).state}');
          }),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return ElevatedButton(
                onPressed: (() {
                  ref.read(counterProvider.state).state =
                      ref.read(counterProvider.state).state + 10;
                }),
                child: const Text(
                  'Add 10',
                  style: TextStyle(fontSize: 20.0),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
