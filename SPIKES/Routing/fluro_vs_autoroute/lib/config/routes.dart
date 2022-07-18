import 'package:fluro/fluro.dart';
import 'package:fluro_example_code/components/home_component.dart';
import 'package:fluro_example_code/components/items_list_component.dart';
import 'package:fluro_example_code/components/item_component.dart';
import 'package:flutter/material.dart';

import '../mock/product.dart';

class Routes {
  final router = FluroRouter();

  static String root = "/";
  static String itemsListRoute = "/components/";
  static String itemRoute = "/components/:product";

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

  static void configureRoutes(FluroRouter router) {
    router.define(root, handler: _rootHandler);
    router.define(itemsListRoute, handler: _itemsListHandler);
    router.define(itemRoute, handler: _itemHandler);
  }
}
