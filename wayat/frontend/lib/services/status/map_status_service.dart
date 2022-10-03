import 'package:get_it/get_it.dart';
import 'package:wayat/services/common/api_contract/api_contract.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';

class LifeCycleService {
  final HttpProvider httpProvider = GetIt.I.get<HttpProvider>();

  ///Send [POST] request to backend to [Open GoogleMap]
  Future sendMapOpened() async {
    await httpProvider.sendPostRequest(APIContract.updateMap, {"open": true});
  }

  ///Send [POST] request to backend to [Close GoogleMap]
  Future sendMapClosed() async {
    await httpProvider.sendPostRequest(APIContract.updateMap, {"open": false});
  }
}
