import 'dart:convert';
import 'dart:io';
import 'package:flutter_config/flutter_config.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:wayat/services/authentication/gauth_service.dart';
import 'package:wayat/services/request/request_service.dart';

class RequestServiceImpl extends RequestService{
  late String _baseUrl;

  RequestServiceImpl() {
    if (Platform.isAndroid) {
      _baseUrl = FlutterConfig.get('ANDROID_BASE_URL')!;
    } else {
      _baseUrl = FlutterConfig.get('BASE_URL')!;
    }
  }
  
  @override
  Future<Map<String, dynamic>> sendGetRequest(String subPath) async {
    GoogleAuthService authService = GetIt.I.get<GoogleAuthService>();
    http.Response resultJson = await http.get(
        Uri.parse("$_baseUrl/$subPath"),
        headers: { 
          "Accept" : "application/json",
          "IdToken" : await authService.getIdToken()
        });
    return json.decode(resultJson.body).cast<Map<String, dynamic>>();
  }
}