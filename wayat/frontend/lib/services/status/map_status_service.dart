import 'package:wayat/services/request/rest_service.dart';

class MapStatusService extends RESTService{
  
  Future sendMapOpened() async {
    await super.sendPostRequest('map/update-map', 
      {
        "open" : true
      }
    );
  }

  Future sendMapClosed() async {
    await super.sendPostRequest('map/update-map', 
      {
        "open" : false
      }
    );
  }
}