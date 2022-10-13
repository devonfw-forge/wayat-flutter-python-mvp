import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  final Widget child;
  const HomePage({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home page")),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_rounded), label: "Bottom menu"),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded), label: "Bottom Menu 2"),
        ],
        currentIndex: _calculateSelectedIndex(context),
        onTap: (int idx) => _onItemTapped(idx, context),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final GoRouter route = GoRouter.of(context);
    final String location = route.location;
    if (location.startsWith('/first')) {
      return 0;
    }
    if (location.startsWith('/second')) {
      return 1;
    }
    if (location.startsWith('/third')) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/first');
        break;
      case 1:
        GoRouter.of(context).go('/second');
        break;
      case 2:
        GoRouter.of(context).go('/third');
        break;
    }
  }
}
