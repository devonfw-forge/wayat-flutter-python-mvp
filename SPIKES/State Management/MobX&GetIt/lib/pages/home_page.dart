import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobxandgetit/pages/shopping_cart_page.dart';
import 'package:mobxandgetit/store/cart_item/default/product_list.dart';
import 'package:mobxandgetit/store/cart_item/product.dart';
import 'package:mobxandgetit/store/shopping_cart/shopping_cart.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<Product> products = ProductList.productList;
  final ShoppingCart shoppingCartState = GetIt.I.get<ShoppingCart>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select items"),
        actions: [
          Observer(
            builder: (_) => Badge(
              position: const BadgePosition(start: 20, bottom: 25),
              badgeContent: Text(shoppingCartState.totalItems.toString()),
              showBadge: shoppingCartState.totalItems > 0,
              child: IconButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShoppingCartPage())),
                icon: const Icon(Icons.shopping_cart_rounded),
                splashRadius: 20,
              ),
            ),
          )
        ],
      ),
      body: ListView.builder(
          itemCount: products.length,
          itemBuilder: ((context, index) => Observer(
                builder: (_) => ListTile(
                  leading: (shoppingCartState.contains(products[index]))
                      ? Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: const Icon(Icons.check_rounded))
                      : IconButton(
                          icon: const Icon(Icons.add_rounded),
                          splashRadius: 20,
                          onPressed: () =>
                              shoppingCartState.addCartItem(products[index]),
                        ),
                  title: Text(products[index].name),
                  trailing: Text("${products[index].price}€"),
                ),
              ))),
    );
  }
}
