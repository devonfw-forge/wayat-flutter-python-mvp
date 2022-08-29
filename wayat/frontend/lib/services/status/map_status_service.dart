import 'package:wayat/services/api_contract/api_contract.dart';
import 'package:wayat/services/request/rest_service.dart';

class MapStatusService extends RESTService {
  Future sendMapOpened() async {
    await super.sendPostRequest(APIContract.updateMap, {"open": true});
  }

  Future sendMapClosed() async {
    await super.sendPostRequest(APIContract.updateMap, {"open": false});
  }
}
