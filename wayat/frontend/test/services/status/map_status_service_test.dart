import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/services/common/api_contract/api_contract.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/status/map_status_service.dart';

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
            .sendPostRequest(APIContract.updateMap, {"open": true}))
        .thenAnswer((_) async => mockResponse);

    MapStatusService mapStatusService = MapStatusService();

    await mapStatusService.sendMapOpened();

    verify(mockHttpProvider
        .sendPostRequest(APIContract.updateMap, {"open": true})).called(1);
  });

  test("sendMapClosed calls the correct endpoint", () async {
    Response mockResponse = MockResponse();
    when(mockHttpProvider
            .sendPostRequest(APIContract.updateMap, {"open": false}))
        .thenAnswer((_) async => mockResponse);

    MapStatusService mapStatusService = MapStatusService();

    await mapStatusService.sendMapClosed();

    verify(mockHttpProvider
        .sendPostRequest(APIContract.updateMap, {"open": false})).called(1);
  });
}
