import 'package:get_it/get_it.dart';
import 'package:wayat/services/common/api_contract/api_contract.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';

class MapStatusService {
  final HttpProvider httpProvider = GetIt.I.get<HttpProvider>();

  Future sendMapOpened() async {
    await httpProvider.sendPostRequest(APIContract.updateMap, {"open": true});
  }

  Future sendMapClosed() async {
    await httpProvider.sendPostRequest(APIContract.updateMap, {"open": false});
  }
}
