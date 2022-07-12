import 'package:mobx/mobx.dart';
import 'package:mobxandgetit/store/cart_item/product.dart';

part 'shopping_cart.g.dart';

class ShoppingCart = _ShoppingCart with _$ShoppingCart;

abstract class _ShoppingCart with Store {
  @observable
  ObservableMap<Product, int> products = ObservableMap();

  @computed
  double get totalPrice => products.keys.fold(
      0,
      (previousValue, product) =>
          previousValue + (product.price * products[product]!));

  @computed
  int get totalItems => products.length;

  bool contains(Product product) =>
      products.keys.where((element) => element == product).isNotEmpty;

  int? quantityWithIndex(int index) => products[products.keys.elementAt(index)];

  double itemPrice(Product product) => product.price * products[product]!;

  @action
  void updateQuantityOfProduct(int quantity, Product product) {
    products[product] = quantity;
  }

  @action
  void addCartItem(Product product) {
    products[product] = 1;
  }

  @action
  void removeCartItem(Product product) {
    products.removeWhere((key, value) => key == product);
  }
}
