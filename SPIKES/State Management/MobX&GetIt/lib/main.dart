import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobxandgetit/pages/home_page.dart';
import 'package:mobxandgetit/store/shopping_cart/shopping_cart.dart';

void main() {
  registerStores();
  runApp(const MyApp());
}

void registerStores() {
  GetIt.I.registerLazySingleton<ShoppingCart>(() => ShoppingCart());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
