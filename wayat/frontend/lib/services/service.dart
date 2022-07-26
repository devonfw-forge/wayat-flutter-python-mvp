import 'package:flutter_dotenv/flutter_dotenv.dart';

class Service {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';
}
