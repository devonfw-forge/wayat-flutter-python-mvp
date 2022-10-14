import 'package:get_it/get_it.dart';
import 'package:wayat/services/common/api_contract/api_contract.dart';
import 'package:wayat/services/notification/notification_service.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';

class NotificationServiceImpl implements NotificationService {
  final HttpProvider httpProvider = GetIt.I.get<HttpProvider>();

  ///Update profile name from [token]
  ///
  ///send [POST] response to backend to send current user token
  @override
  Future<bool> sendCurrentUserToken(String token) async {
    bool done = (await httpProvider.sendPostRequest(
                    APIContract.pushNotification, {"token": token}))
                .statusCode /
            10 ==
        20;
    return done;
  }
}
