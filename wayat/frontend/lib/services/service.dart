import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Service {
  String baseUrl = dotenv.get('BASE_URL');
}
