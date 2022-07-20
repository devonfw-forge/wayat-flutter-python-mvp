import 'package:fluro_example_code/components/bottom_menu.dart';
import 'package:fluro_example_code/components/bottom_menu2.dart';
import 'package:fluro_example_code/config/application.dart';
import 'package:fluro_example_code/config/routes.dart';
import 'package:flutter/material.dart';

class HomeComponent extends StatefulWidget {
  const HomeComponent({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeComponent> createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent> {
  int currentIndex = 0;
  final screens = [
    const HomeComponent(title: 'Home Page'),
    const BottomMenuComponent(),
    const BottomMenuSecondComponent()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: ElevatedButton(
                onPressed: buttonTapped,
                child: const Text("Navigate to items page"))),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu_rounded), label: "Bottom menu"),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_rounded), label: "Bottom Menu 2"),
          ],
          onTap: (currentIndex) {
            switch (currentIndex) {
              case 0:
                Application.router.navigateTo(context, Routes.root);
                break;
              case 1:
                Application.router.navigateTo(context, Routes.bottomMenu);
                break;
              case 2:
                Application.router.navigateTo(context, Routes.bottomMenu2);
                break;
            }
          },
        ));
  }

  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void buttonTapped() {
    Application.router.navigateTo(context, Routes.itemsListRoute);
  }
}
