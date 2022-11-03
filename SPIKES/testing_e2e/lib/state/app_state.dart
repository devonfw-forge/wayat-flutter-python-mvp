import 'package:mobx/mobx.dart';
import 'package:testing_e2e/products_service/products_service.dart';

import '../http_responses/product.dart';

part 'app_state.g.dart';

// ignore: library_private_types_in_public_api
class AppState = _AppState with _$AppState;

abstract class _AppState with Store {
  ProductService productService = ProductService();
  @observable
  bool viewList = false;

  List<Product> products = [];

  static ObservableFuture<List<Product>> emptyResponse =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<Product>> fetchProducts = emptyResponse;

  @computed
  bool get hasResults =>
      fetchProducts != emptyResponse &&
      fetchProducts.status == FutureStatus.fulfilled;

  @observable
  Product? selectedProduct;

  @observable
  ObservableList<Product> selectedProducts = ObservableList.of([]);

  @action
  Future<List<Product>> getAllProducts() async {
    final future = productService.getAllProducts();
    fetchProducts = ObservableFuture(future);
    return products = await future;
  }
}
