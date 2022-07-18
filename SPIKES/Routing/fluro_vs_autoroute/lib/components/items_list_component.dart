import 'package:fluro_example_code/config/routes.dart';
import 'package:fluro_example_code/mock/product.dart';

import '../config/application.dart';
import '../mock/data_items.dart';
import 'package:flutter/material.dart';

class ItemsListComponent extends StatelessWidget {
  ItemsListComponent({Key? key}) : super(key: key);

  final List<Product> products = ProductList.productList;
  get context => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("List items")),
        body: Center(
            child: ListView.builder(
                itemCount: products.length,
                itemBuilder: ((context, index) => ListTile(
                      leading: IconButton(
                          icon: const Icon(Icons.info_rounded),
                          splashRadius: 20,
                          onPressed: () =>
                              itemTapped(context, products[index])),
                      title: Text(products[index].name),
                      trailing: Text("${products[index].price}€"),
                    )))));
  }

  itemTapped(BuildContext context, Product product) {
    Application.router.navigateTo(context, Routes.itemRoute,
        routeSettings: RouteSettings(arguments: product));
  }
}
