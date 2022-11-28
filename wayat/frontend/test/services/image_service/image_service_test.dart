import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:http/http.dart' as http;
import 'package:wayat/services/image_service/image_service.dart';

import 'image_service_test.mocks.dart';

@GenerateMocks([HttpProvider, http.Response])
void main() async {
  HttpProvider mockHttpProvider = MockHttpProvider();

  setUpAll(() {
    GetIt.I.registerSingleton<HttpProvider>(mockHttpProvider);
  });

  test("getBitmapsFromUrl called with the correct data", () async {

    ImageService imageService = ImageService();

    await imageService.getBitmapsFromUrl(['https://play-lh.googleusercontent.com/6UgEjh8Xuts4nwdWzTnWH8QtLuHqRMUB7dp24JYVE2xcYzq4HA8hFfcAbU-R-PC_9uA1']);

  });
}
