import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/services/common/api_contract/api_contract.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/notification/notifications_service_impl.dart';

import 'notification_service_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<HttpProvider>(),
  MockSpec<Response>(),
])
void main() async {
  HttpProvider mockHttpProvider = MockHttpProvider();

  setUpAll(() {
    GetIt.I.registerSingleton(mockHttpProvider);
  });

  test("Send FCM token to backend", () async {
    Response mockHttpResponse = MockResponse();
    when(mockHttpResponse.statusCode).thenReturn(200);
    String token = "test token";
    when(mockHttpProvider
            .sendPostRequest(APIContract.pushNotification, {"token": token}))
        .thenAnswer((_) async => mockHttpResponse);

    NotificationsServiceImpl notificationService = NotificationsServiceImpl();

    await notificationService.sendNotificationsToken(token);

    verify(mockHttpProvider.sendPostRequest(
        APIContract.pushNotification, {"token": token})).called(1);
  });
}
