import 'package:mobx/mobx.dart';

import 'package:auto_route_example/mock/data_items.dart';
import 'package:auto_route_example/mock/product.dart';

part 'app_state.g.dart';

// ignore: library_private_types_in_public_api
class AppState = _AppState with _$AppState;

abstract class _AppState with Store {
  @observable
  bool viewList = false;

  @observable
  Product? selectedProduct;

  @observable
  ObservableList<Product> selectedProducts = ObservableList.of([]);

  List<Product> get allProducts => ProductList.productList;
}
