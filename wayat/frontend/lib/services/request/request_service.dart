import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/services/authentication/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:wayat/services/service.dart';

abstract class RequestService extends Service {
  /// Generetes a *dictionary* with the headers for backend connection
  Future<Map<String, String>> _getHeaders() async{
    AuthService authService = GetIt.I.get<SessionState>().authService;
    return { 
      "Content-Type" : "application/json",
      "Authorization" : "Bearer ${await authService.getIdToken()}"
    };
  }
  
  /// Sends a **GET** request to [baseUrl]/[subPath], using the configured authentication
  Future<Map<String, dynamic>> sendGetRequest(String subPath) async {
    http.Response resultJson = await http.get(
      Uri.parse("$baseUrl/$subPath"),
      headers: await _getHeaders()
    );
    return json.decode(resultJson.body) as Map<String, dynamic>;
  }
  
  /// Sends a **POST** request to [baseUrl]/[subPath] and with [body] as content, 
  /// using the configured authentication
  Future<bool> sendPostRequest(String subPath, Map<String, dynamic> body) async {
    http.Response resultJson = await http.post(
      Uri.parse("$baseUrl/$subPath"),
      headers: await _getHeaders(),
      body: jsonEncode(body)
    );
    // Checks if a 20X status code is returned
    return resultJson.statusCode/10 == 20;
  }
  
  /// Sends a **PUT** request to [baseUrl]/[subPath] and with [body] as content, 
  /// using the configured authentication
  Future<bool> sendPutRequest(String subPath, Map<String, dynamic> body) async {
    http.Response resultJson = await http.put(
      Uri.parse("$baseUrl/$subPath"),
      headers: await _getHeaders(),
      body: body
    );
    // Checks if a 20X status code is returned
    return resultJson.statusCode/10 == 20;
  }
  
  /// Sends a **DEL** request to [baseUrl]/[subPath], using the configured authentication
  Future<bool> sendDelRequest(String subPath) async {
    http.Response resultJson = await http.delete(
      Uri.parse("$baseUrl/$subPath"),
      headers: await _getHeaders()
    );
    // Checks if a 20X status code is returned
    return resultJson.statusCode/10 == 20;
  }
}