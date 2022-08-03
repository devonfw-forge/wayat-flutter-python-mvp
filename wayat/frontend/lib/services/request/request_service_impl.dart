import 'dart:convert';
import 'dart:io';
import 'package:flutter_config/flutter_config.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:wayat/services/authentication/auth_service.dart';
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

  Future<Map<String, String>> _getHeaders() async{
    AuthService authService = GetIt.I.get<AuthService>();
    return { 
      "Accept" : "application/json",
      "IdToken" : await authService.getIdToken()
    };
  }
  
  @override
  Future<Map<String, dynamic>> sendGetRequest(String subPath) async {
    http.Response resultJson = await http.get(
      Uri.parse("$_baseUrl/$subPath"),
      headers: await _getHeaders()
    );
    return json.decode(resultJson.body).cast<Map<String, dynamic>>();
  }
  
  @override
  Future<bool> sendPostRequest(String subPath, Map<String, dynamic> body) async {
    http.Response resultJson = await http.post(
      Uri.parse("$_baseUrl/$subPath"),
      headers: await _getHeaders(),
      body: body
    );
    return resultJson.statusCode/10 == 20;
  }
  
  @override
  Future<bool> sendPutRequest(String subPath, Map<String, dynamic> body) async {
    http.Response resultJson = await http.put(
      Uri.parse("$_baseUrl/$subPath"),
      headers: await _getHeaders(),
      body: body
    );
    return resultJson.statusCode/10 == 20;
  }
  
  @override
  Future<Map<String, dynamic>> sendDelRequest(String subPath) async {
    http.Response resultJson = await http.delete(
      Uri.parse("$_baseUrl/$subPath"),
      headers: await _getHeaders()
    );
    return json.decode(resultJson.body).cast<Map<String, dynamic>>();
  }
}