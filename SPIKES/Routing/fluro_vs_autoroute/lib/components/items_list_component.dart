import 'package:fluro_example_code/config/routes.dart';

import '../config/application.dart';
import '../mock/data_items.dart';
import 'package:flutter/material.dart';

class ItemsListComponent extends StatelessWidget {
  ItemsListComponent({Key? key}) : super(key: key);

  final products = ProductList.productList;
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
                          onPressed:
                              () {}), //I try to set here itemTapped(products[index]), but it's not worked
                      title: Text(products[index].name),
                      trailing: Text("${products[index].price}€"),
                    )))));
  }

  itemTapped(product) async {
    return Application.router.navigateTo(context, Routes.itemRoute[product]);
  }
}
