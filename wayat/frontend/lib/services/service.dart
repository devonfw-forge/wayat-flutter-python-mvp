import 'package:flutter_config/flutter_config.dart';

abstract class Service {
  String baseUrl = FlutterConfig.get('BASE_URL')!;
}
