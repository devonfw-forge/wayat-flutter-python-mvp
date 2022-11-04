import 'package:flutter/material.dart';

import '../http_responses/product.dart';

class ItemPage extends StatelessWidget {
  final Product product;

  const ItemPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Item page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${product.title}",
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${product.price}€",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${product.description}",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${product.category}",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "rate: ${product.rating?.rate} count: ${product.rating?.count}",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
