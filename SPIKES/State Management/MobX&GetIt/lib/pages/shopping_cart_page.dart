import 'package:counter_button/counter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobxandgetit/store/shopping_cart/shopping_cart.dart';

class ShoppingCartPage extends StatelessWidget {
  ShoppingCartPage({Key? key}) : super(key: key);

  final ShoppingCart shoppingCartState = GetIt.I.get<ShoppingCart>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your cart"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Observer(
              builder: (_) => ListView.separated(
                shrinkWrap: true,
                itemCount: shoppingCartState.products.length,
                itemBuilder: ((context, index) => ListTile(
                      leading: CounterButton(
                        loading: false,
                        count: shoppingCartState.quantityWithIndex(index)!,
                        onChange: (quantity) {
                          shoppingCartState.updateQuantityOfProduct(quantity,
                              shoppingCartState.products.keys.elementAt(index));
                        },
                      ),
                      title: Text(shoppingCartState.products.keys
                          .elementAt(index)
                          .name),
                      trailing: Text(
                          "${shoppingCartState.itemPrice(shoppingCartState.products.keys.elementAt(index))}€"),
                    )),
                separatorBuilder: (_, __) => const SizedBox(
                  height: 10,
                ),
              ),
            ),
            const Divider(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total: ",
                    style: TextStyle(fontSize: 18),
                  ),
                  Observer(
                      builder: (_) => Text(
                            "${shoppingCartState.totalPrice}€",
                            style: const TextStyle(fontSize: 18),
                          ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
