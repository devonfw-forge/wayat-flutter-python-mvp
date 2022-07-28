import 'package:fluro/fluro.dart';
import 'package:fluro_example_code/components/bottom_menu2.dart';
import 'package:fluro_example_code/components/home_component.dart';
import 'package:fluro_example_code/components/items_list_component.dart';
import 'package:fluro_example_code/components/item_component.dart';
import 'package:flutter/material.dart';
import '../components/bottom_menu.dart';
import '../mock/product.dart';

class Routes {
  final router = FluroRouter();

  static String root = "/";
  static String itemsListRoute = "/components/";
  static String itemRoute = "/components/:product";
  static String bottomMenu = "/bottomMenu";
  static String bottomMenu2 = "/bottomMenu2";

  static final Handler _rootHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    return const HomeComponent(title: 'Home Page');
  });

  static final Handler _itemsListHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    return ItemsListComponent();
  });

  static final Handler _itemHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    Product? product = context?.settings?.arguments as Product;
    return ItemComponent(product: product);
  });

  static final Handler _bottomMenuHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    return const BottomMenuComponent();
  });

  static final Handler _bottomMenu2Handler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    return const BottomMenuSecondComponent();
  });

  static void configureRoutes(FluroRouter router) {
    router.define(root, handler: _rootHandler);
    router.define(itemsListRoute, handler: _itemsListHandler);
    router.define(itemRoute, handler: _itemHandler);
    router.define(bottomMenu, handler: _bottomMenuHandler);
    router.define(bottomMenu2, handler: _bottomMenu2Handler);
  }
}
