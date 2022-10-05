import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/services/authentication/auth_service.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';

import 'http_provider_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<http.Client>(), MockSpec<AuthService>(), MockSpec<UserState>()])
void main() async {
  UserState mockUserState = MockUserState();
  AuthService mockAuthService = MockAuthService();
  late String baseUrl;

  setUpAll(() async {
    await dotenv.load();
    baseUrl = dotenv.get('BASE_URL');

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

  test("sendPostImageRequest is correct", () async {
    String filePath = "test_resources/wayat_icon.png";
    http.Client mockClient = MockClient();

    HttpProvider httpProvider = HttpProvider(client: mockClient);

    http.StreamedResponse providerResponse = await httpProvider
        .sendPostImageRequest("subPath", filePath, "image/png");

    expect(providerResponse, isA<http.StreamedResponse>());
  });
}
