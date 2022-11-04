import 'package:testing_e2e/http_responses/product.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<List<Product>> getAllProducts() async {
    final List<Product> products = productsFromJson(
        (await http.get(Uri.parse('https://fakestoreapi.com/products'))).body);
    return products;
  }
}
