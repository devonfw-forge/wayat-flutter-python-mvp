import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/services/common/api_contract/api_contract.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/status/lifecycle_service.dart';

import 'map_status_service_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HttpProvider>(), MockSpec<Response>()])
void main() async {
  HttpProvider mockHttpProvider = MockHttpProvider();

  setUpAll(() {
    GetIt.I.registerSingleton(mockHttpProvider);
  });

  test("sendMapOpened calls the correct endpoint", () async {
    Response mockResponse = MockResponse();
    when(mockHttpProvider
            .sendPostRequest(APIContract.updateLifeCycle, {"open": true}))
        .thenAnswer((_) async => mockResponse);

    LifeCycleService lifeCycleService = LifeCycleService();

    await lifeCycleService.notifyMapOpened();

    verify(mockHttpProvider.sendPostRequest(
        APIContract.updateLifeCycle, {"open": true})).called(1);
  });

  test("sendMapClosed calls the correct endpoint", () async {
    Response mockResponse = MockResponse();
    when(mockHttpProvider
            .sendPostRequest(APIContract.updateLifeCycle, {"open": false}))
        .thenAnswer((_) async => mockResponse);

    LifeCycleService lifeCycleService = LifeCycleService();

    await lifeCycleService.notifyMapClosed();

    verify(mockHttpProvider.sendPostRequest(
        APIContract.updateLifeCycle, {"open": false})).called(1);
  });
}
