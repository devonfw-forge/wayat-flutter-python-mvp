// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_cart.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ShoppingCart on _ShoppingCart, Store {
  Computed<double>? _$totalPriceComputed;

  @override
  double get totalPrice =>
      (_$totalPriceComputed ??= Computed<double>(() => super.totalPrice,
              name: '_ShoppingCart.totalPrice'))
          .value;
  Computed<int>? _$totalItemsComputed;

  @override
  int get totalItems =>
      (_$totalItemsComputed ??= Computed<int>(() => super.totalItems,
              name: '_ShoppingCart.totalItems'))
          .value;

  late final _$productsAtom =
      Atom(name: '_ShoppingCart.products', context: context);

  @override
  ObservableMap<Product, int> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(ObservableMap<Product, int> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$_ShoppingCartActionController =
      ActionController(name: '_ShoppingCart', context: context);

  @override
  void updateQuantityOfProduct(int quantity, Product product) {
    final _$actionInfo = _$_ShoppingCartActionController.startAction(
        name: '_ShoppingCart.updateQuantityOfProduct');
    try {
      return super.updateQuantityOfProduct(quantity, product);
    } finally {
      _$_ShoppingCartActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addCartItem(Product product) {
    final _$actionInfo = _$_ShoppingCartActionController.startAction(
        name: '_ShoppingCart.addCartItem');
    try {
      return super.addCartItem(product);
    } finally {
      _$_ShoppingCartActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeCartItem(Product product) {
    final _$actionInfo = _$_ShoppingCartActionController.startAction(
        name: '_ShoppingCart.removeCartItem');
    try {
      return super.removeCartItem(product);
    } finally {
      _$_ShoppingCartActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
products: ${products},
totalPrice: ${totalPrice},
totalItems: ${totalItems}
    ''';
  }
}
