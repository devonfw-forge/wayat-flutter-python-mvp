import 'dart:convert';
import 'dart:io';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/services/authentication/auth_service.dart';
import 'package:wayat/services/service.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/src/media_type.dart';

abstract class RESTService extends Service {
  /// Generetes a *dictionary* with the headers for backend connection
  Future<Map<String, String>> _getHeaders() async {
    AuthService authService = GetIt.I.get<SessionState>().authService;
    return {
      "Content-Type": ContentType.json.toString(),
      "Authorization": "Bearer ${await authService.getIdToken()}"
    };
  }

  /// Sends a **GET** request to [baseUrl]/[subPath], using the configured authentication
  Future<Map<String, dynamic>> sendGetRequest(String subPath) async {
    Response resultJson =
        await get(Uri.parse("$baseUrl/$subPath"), headers: await _getHeaders());
    return json.decode(const Utf8Decoder().convert(resultJson.bodyBytes))
        as Map<String, dynamic>;
  }

  /// Sends a **POST** request to [baseUrl]/[subPath] and with [body] as content,
  /// using the configured authentication
  Future<Response> sendPostRequest(
      String subPath, Map<String, dynamic> body) async {
    Response response = await post(Uri.parse("$baseUrl/$subPath"),
        headers: await _getHeaders(), body: jsonEncode(body));
    return response;
  }

  /// Sends a **POST** request to upload ImageFIle [baseUrl]/[subPath] and with [body] as content,
  /// using the configured authentication
  Future<StreamedResponse> sendPostImageRequest(
      String subPath, String filePath, String type) async {
    MultipartRequest request =
        MultipartRequest('POST', Uri.parse("$baseUrl/$subPath"));
    List<int> bytes = await File(filePath).readAsBytes();
    MultipartFile httpImage = MultipartFile.fromBytes('upload_file', bytes,
        contentType: MediaType.parse(type),
        filename: 'upload_file_${filePath.hashCode}.$type');
    request.headers["Authorization"] =
        "Bearer ${await GetIt.I.get<SessionState>().authService.getIdToken()}";
    request.files.add(httpImage);
    return await request.send();
  }

  /// Sends a **PUT** request to [baseUrl]/[subPath] and with [body] as content,
  /// using the configured authentication
  Future<bool> sendPutRequest(String subPath, Map<String, dynamic> body) async {
    Response resultJson = await put(Uri.parse("$baseUrl/$subPath"),
        headers: await _getHeaders(), body: body);
    // Checks if a 20X status code is returned
    return resultJson.statusCode / 10 == 20;
  }

  /// Sends a **DEL** request to [baseUrl]/[subPath], using the configured authentication
  Future<bool> sendDelRequest(String subPath) async {
    Response resultJson = await delete(Uri.parse("$baseUrl/$subPath"),
        headers: await _getHeaders());
    // Checks if a 20X status code is returned
    return resultJson.statusCode / 10 == 20;
  }
}
