import 'package:auto_route/auto_route.dart';
import 'package:auto_route_example/mock/data_items.dart';
import 'package:auto_route_example/navigation/app_router.dart';
import 'package:flutter/material.dart';

class ListItemsPage extends StatelessWidget {
  ListItemsPage({Key? key}) : super(key: key);

  final products = ProductList.productList;

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);

    return Scaffold(
        appBar: AppBar(title: const Text("List items")),
        body: Center(
            child: ListView.builder(
                itemCount: products.length,
                itemBuilder: ((context, index) => ListTile(
                      leading: IconButton(
                          icon: const Icon(Icons.info_rounded),
                          splashRadius: 20,
                          onPressed: () => {
                                router.push(ItemRoute(
                                  product: products[index],
                                ))
                              }),
                      title: Text(products[index].name),
                      trailing: Text("${products[index].price}€"),
                    )))));
  }
}
