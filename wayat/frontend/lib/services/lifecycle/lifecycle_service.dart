import 'package:get_it/get_it.dart';
import 'package:wayat/services/common/api_contract/api_contract.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';

class LifeCycleService {
  final HttpProvider httpProvider = GetIt.I.get<HttpProvider>();

  /// Send [POST] request to backend that map is openned
  Future notifyLifeCycleState(bool isOpened) async {
    await httpProvider
        .sendPostRequest(APIContract.updateLifeCycle, {"open": isOpened});
  }
}
