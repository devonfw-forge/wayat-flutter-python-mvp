import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/common/app_config/env_model.dart';
import 'package:wayat/services/authentication/auth_service.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/common/http_provider/request_error_handler_libw.dart';

import 'http_provider_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<http.Client>(),
  MockSpec<AuthService>(),
  MockSpec<UserState>(),
  MockSpec<RequestErrorHandlerLibW>(),
])
void main() async {
  UserState mockUserState = MockUserState();
  AuthService mockAuthService = MockAuthService();
  late String baseUrl;

  setUpAll(() async {
    baseUrl = EnvModel.BASE_URL;

    when(mockUserState.authService).thenReturn(mockAuthService);
    when(mockAuthService.getIdToken())
        .thenAnswer((realInvocation) => Future.value("idtoken"));

    GetIt.I.registerSingleton<UserState>(mockUserState);
  });

  test("GetHeaders is correct", () async {
    HttpProvider httpProvider = HttpProvider();

    Map<String, String> headers = await httpProvider.getHeaders();
    expect(headers, {
      "Content-Type": ContentType.json.toString(),
      "Authorization": "Bearer idtoken"
    });
  });

  test("SendGetRequest is correct", () async {
    Map<String, String> headers = {
      "Content-Type": ContentType.json.toString(),
      "Authorization": "Bearer idtoken"
    };
    Map<String, dynamic> responseBody = {"key": "value", "number": 1};
    http.Response response = http.Response(jsonEncode(responseBody), 200);

    http.Client mockClient = MockClient();

    when(mockClient.get(Uri.parse("$baseUrl/subPath"), headers: headers))
        .thenAnswer((_) => Future.value(response));

    HttpProvider httpProvider = HttpProvider(client: mockClient);

    Map<String, dynamic> providerResponseBody =
        await httpProvider.sendGetRequest("subPath");

    expect(providerResponseBody, responseBody);
  });

  test("SendGetRequest redirects to error page if there is an exception",
      () async {
    MockRequestErrorHandlerLibW mockRequestErrorHandler =
        MockRequestErrorHandlerLibW();
    Map<String, String> headers = {
      "Content-Type": ContentType.json.toString(),
      "Authorization": "Bearer idtoken"
    };
    http.Client mockClient = MockClient();

    when(mockClient.get(Uri.parse("$baseUrl/subPath"), headers: headers))
        .thenThrow(Exception());

    HttpProvider httpProvider = HttpProvider(client: mockClient);

    Map<String, dynamic> providerResponseBody =
        await httpProvider.sendGetRequest("subPath",
            requestErrorHandler: mockRequestErrorHandler);

    expect(providerResponseBody, {});
    verify(mockRequestErrorHandler.goToErrorPage()).called(1);
  });

  test("SendPostRequest is correct", () async {
    Map<String, String> headers = {
      "Content-Type": ContentType.json.toString(),
      "Authorization": "Bearer idtoken"
    };
    Map<String, dynamic> body = {"key": "value", "number": 1};
    http.Response response = http.Response(jsonEncode(body), 200);

    http.Client mockClient = MockClient();

    when(mockClient.post(Uri.parse("$baseUrl/subPath"),
            headers: headers, body: jsonEncode(body)))
        .thenAnswer((_) => Future.value(response));

    HttpProvider httpProvider = HttpProvider(client: mockClient);

    http.Response providerResponse =
        await httpProvider.sendPostRequest("subPath", body);

    expect(providerResponse, response);
  });

  test("SendPostRequest goes to error page if there is an exception", () async {
    MockRequestErrorHandlerLibW mockRequestErrorHandler =
        MockRequestErrorHandlerLibW();
    Map<String, String> headers = {
      "Content-Type": ContentType.json.toString(),
      "Authorization": "Bearer idtoken"
    };
    Map<String, dynamic> body = {"key": "value", "number": 1};

    http.Client mockClient = MockClient();

    when(mockClient.post(Uri.parse("$baseUrl/subPath"),
            headers: headers, body: jsonEncode(body)))
        .thenThrow(Exception());

    HttpProvider httpProvider = HttpProvider(client: mockClient);

    await httpProvider.sendPostRequest("subPath", body,
        requestErrorHandler: mockRequestErrorHandler);

    verify(mockRequestErrorHandler.goToErrorPage()).called(1);
  });

  test("SendPutRequest is correct", () async {
    Map<String, String> headers = {
      "Content-Type": ContentType.json.toString(),
      "Authorization": "Bearer idtoken"
    };
    Map<String, dynamic> body = {"key": "value", "number": 1};
    http.Response response = http.Response(jsonEncode(body), 200);

    http.Client mockClient = MockClient();

    when(mockClient.put(Uri.parse("$baseUrl/subPath"),
            headers: headers, body: jsonEncode(body)))
        .thenAnswer((_) => Future.value(response));

    HttpProvider httpProvider = HttpProvider(client: mockClient);

    bool providerResponse = await httpProvider.sendPutRequest("subPath", body);

    expect(providerResponse, true);

    http.Response failedResponse = http.Response(jsonEncode(body), 400);
    when(mockClient.put(Uri.parse("$baseUrl/subPath"),
            headers: headers, body: jsonEncode(body)))
        .thenAnswer((_) => Future.value(failedResponse));

    providerResponse = await httpProvider.sendPutRequest("subPath", body);

    expect(providerResponse, false);
  });

  test("SendPutRequest redirects to error page if there is an exception",
      () async {
    MockRequestErrorHandlerLibW mockRequestErrorHandler =
        MockRequestErrorHandlerLibW();
    Map<String, String> headers = {
      "Content-Type": ContentType.json.toString(),
      "Authorization": "Bearer idtoken"
    };
    Map<String, dynamic> body = {"key": "value", "number": 1};

    http.Client mockClient = MockClient();

    when(mockClient.put(Uri.parse("$baseUrl/subPath"),
            headers: headers, body: jsonEncode(body)))
        .thenThrow(Exception());

    HttpProvider httpProvider = HttpProvider(client: mockClient);

    await httpProvider.sendPutRequest("subPath", body,
        requestErrorHandler: mockRequestErrorHandler);

    verify(mockRequestErrorHandler.goToErrorPage()).called(1);
  });

  test("SendDelRequest is correct", () async {
    Map<String, String> headers = {
      "Content-Type": ContentType.json.toString(),
      "Authorization": "Bearer idtoken"
    };
    Map<String, dynamic> body = {"key": "value", "number": 1};
    http.Response response = http.Response(jsonEncode(body), 200);

    http.Client mockClient = MockClient();

    when(mockClient.delete(Uri.parse("$baseUrl/subPath"), headers: headers))
        .thenAnswer((_) => Future.value(response));

    HttpProvider httpProvider = HttpProvider(client: mockClient);

    bool providerResponse = await httpProvider.sendDelRequest("subPath");

    expect(providerResponse, true);

    http.Response failedResponse = http.Response(jsonEncode(body), 400);

    when(mockClient.delete(Uri.parse("$baseUrl/subPath"), headers: headers))
        .thenAnswer((_) => Future.value(failedResponse));

    providerResponse = await httpProvider.sendDelRequest("subPath");

    expect(providerResponse, false);
  });

  test("SendDelRequest redirects to error page if there is an error", () async {
    MockRequestErrorHandlerLibW mockRequestErrorHandler =
        MockRequestErrorHandlerLibW();
    Map<String, String> headers = {
      "Content-Type": ContentType.json.toString(),
      "Authorization": "Bearer idtoken"
    };
    Map<String, dynamic> body = {"key": "value", "number": 1};
    http.Response response = http.Response(jsonEncode(body), 200);

    http.Client mockClient = MockClient();

    when(mockClient.delete(Uri.parse("$baseUrl/subPath"), headers: headers))
        .thenAnswer((_) => Future.value(response));

    HttpProvider httpProvider = HttpProvider(client: mockClient);

    when(mockClient.delete(Uri.parse("$baseUrl/subPath"), headers: headers))
        .thenThrow(Exception());

    await httpProvider.sendDelRequest("subPath",
        requestErrorHandler: mockRequestErrorHandler);

    verify(mockRequestErrorHandler.goToErrorPage()).called(1);
  });

  test("sendPostImageRequest is correct", () async {
    Uint8List imageTestBytes =
        await File("test_resources/wayat_icon.png").readAsBytes();
    http.Client mockClient = MockClient();

    HttpProvider httpProvider = HttpProvider(client: mockClient);

    http.StreamedResponse providerResponse = await httpProvider
        .sendPostImageRequest("subPath", imageTestBytes, "image/png");

    expect(providerResponse, isA<http.StreamedResponse>());
  });

  test("sendPostImageRequest throws an exception if there is an error",
      () async {
    MockRequestErrorHandlerLibW mockRequestErrorHandler =
        MockRequestErrorHandlerLibW();
    Uint8List imageTestBytes =
        await File("test_resources/wayat_icon.png").readAsBytes();
    MockClient mockClient = MockClient();

    when(mockClient.send(any)).thenThrow(Exception());

    HttpProvider httpProvider = HttpProvider(client: mockClient);

    await httpProvider.sendPostImageRequest(
        "subPath", imageTestBytes, "image/png",
        requestErrorHandler: mockRequestErrorHandler);

    verify(mockRequestErrorHandler.goToErrorPage()).called(1);
  });
}
