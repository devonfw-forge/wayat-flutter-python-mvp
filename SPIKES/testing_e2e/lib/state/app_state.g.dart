// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppState on _AppState, Store {
  late final _$viewListAtom =
      Atom(name: '_AppState.viewList', context: context);

  @override
  bool get viewList {
    _$viewListAtom.reportRead();
    return super.viewList;
  }

  @override
  set viewList(bool value) {
    _$viewListAtom.reportWrite(value, super.viewList, () {
      super.viewList = value;
    });
  }

  late final _$selectedProductAtom =
      Atom(name: '_AppState.selectedProduct', context: context);

  @override
  Product? get selectedProduct {
    _$selectedProductAtom.reportRead();
    return super.selectedProduct;
  }

  @override
  set selectedProduct(Product? value) {
    _$selectedProductAtom.reportWrite(value, super.selectedProduct, () {
      super.selectedProduct = value;
    });
  }

  late final _$selectedProductsAtom =
      Atom(name: '_AppState.selectedProducts', context: context);

  @override
  ObservableList<Product> get selectedProducts {
    _$selectedProductsAtom.reportRead();
    return super.selectedProducts;
  }

  @override
  set selectedProducts(ObservableList<Product> value) {
    _$selectedProductsAtom.reportWrite(value, super.selectedProducts, () {
      super.selectedProducts = value;
    });
  }

  @override
  String toString() {
    return '''
viewList: ${viewList},
selectedProduct: ${selectedProduct},
selectedProducts: ${selectedProducts}
    ''';
  }
}
