import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/common/app_config/env_model.dart';
import 'package:wayat/services/authentication/auth_service.dart';
// ignore: depend_on_referenced_packages, implementation_imports
import 'package:http_parser/src/media_type.dart';
import 'package:wayat/services/common/http_provider/request_error_handler_libw.dart';

/// Encapsulates the proccess of making authorized HTTP requests from the services.
///
/// This allows for mocking all HTTP requests in service testing and also,
/// reduces code duplication by abstracting this proccess.
class HttpProvider {
  /// Client that will make all requests
  final http.Client client;

  /// Creates an [HttpProvider].
  ///
  /// The optional [http.CLient] argument is added for testing purposes.
  HttpProvider({http.Client? client}) : client = client ?? http.Client();

  /// Gets the base url of the server using environment variables.
  String baseUrl = EnvModel.BASE_URL;

  /// Returns the necessary content and authentication headers for all server requests.
  @visibleForTesting
  Future<Map<String, String>> getHeaders() async {
    AuthService authService = GetIt.I.get<UserState>().authService;
    return {
      "Content-Type": ContentType.json.toString(),
      "Authorization": "Bearer ${await authService.getIdToken()}"
    };
  }

  /// Sends a `GET` request to `baseUrl`/`subPath`.
  Future<Map<String, dynamic>> sendGetRequest(String subPath,
      {RequestErrorHandlerLibW? requestErrorHandler}) async {
    try {
      final headers = await getHeaders();
      http.Response resultJson =
          await client.get(Uri.parse("$baseUrl/$subPath"), headers: headers);
      return json.decode(const Utf8Decoder().convert(resultJson.bodyBytes))
          as Map<String, dynamic>;
    } on Exception {
      RequestErrorHandlerLibW requestErrorHandlerLibW =
          requestErrorHandler ?? RequestErrorHandlerLibW();
      requestErrorHandlerLibW.goToErrorPage();
      return {};
    }
  }

  /// Sends a `POST` request to `baseUrl`/`subPath` with `body` as the content.
  Future<http.Response> sendPostRequest(
      String subPath, Map<String, dynamic> body,
      {RequestErrorHandlerLibW? requestErrorHandler}) async {
    try {
      http.Response response = await client.post(Uri.parse("$baseUrl/$subPath"),
          headers: await getHeaders(), body: jsonEncode(body));
      return response;
    } on Exception {
      RequestErrorHandlerLibW requestErrorHandlerLibW =
          requestErrorHandler ?? RequestErrorHandlerLibW();
      requestErrorHandlerLibW.goToErrorPage();
      return http.Response("", 500);
    }
  }

  /// Sends a `POST` multipart request to upload the image located at `filePath` to `baseUrl`/`subPath`.
  Future<http.StreamedResponse> sendPostImageRequest(
      String subPath, Uint8List fileBytes, String type,
      {RequestErrorHandlerLibW? requestErrorHandler}) async {
    try {
      http.MultipartRequest request =
          http.MultipartRequest('POST', Uri.parse("$baseUrl/$subPath"));
      List<int> bytes = fileBytes;
      http.MultipartFile httpImage = http.MultipartFile.fromBytes(
          'upload_file', bytes,
          contentType: MediaType.parse(type),
          filename: 'upload_file_${fileBytes.hashCode}.$type');
      request.headers["Authorization"] =
          "Bearer ${await GetIt.I.get<UserState>().authService.getIdToken()}";
      request.files.add(httpImage);
      return await client.send(request);
    } on Exception {
      RequestErrorHandlerLibW requestErrorHandlerLibW =
          requestErrorHandler ?? RequestErrorHandlerLibW();
      requestErrorHandlerLibW.goToErrorPage();
      return http.StreamedResponse(const Stream.empty(), 500);
    }
  }

  /// Sends a `PUT` request to `baseUrl`/`subPath` and with `body` as content.
  Future<bool> sendPutRequest(String subPath, Map<String, dynamic> body,
      {RequestErrorHandlerLibW? requestErrorHandler}) async {
    try {
      http.Response resultJson = await client.put(
          Uri.parse("$baseUrl/$subPath"),
          headers: await getHeaders(),
          body: jsonEncode(body));
      // Checks if a 20X status code is returned
      return resultJson.statusCode / 10 == 20;
    } on Exception {
      RequestErrorHandlerLibW requestErrorHandlerLibW =
          requestErrorHandler ?? RequestErrorHandlerLibW();
      requestErrorHandlerLibW.goToErrorPage();
      return false;
    }
  }

  /// Sends a `DEL` request to `baseUrl`/`subPath`.
  Future<bool> sendDelRequest(String subPath,
      {RequestErrorHandlerLibW? requestErrorHandler}) async {
    try {
      http.Response resultJson = await client
          .delete(Uri.parse("$baseUrl/$subPath"), headers: await getHeaders());
      // Checks if a 20X status code is returned
      return resultJson.statusCode / 10 == 20;
    } on Exception {
      RequestErrorHandlerLibW requestErrorHandlerLibW =
          requestErrorHandler ?? RequestErrorHandlerLibW();
      requestErrorHandlerLibW.goToErrorPage();
      return false;
    }
  }
}
