
abstract class RequestService {
  Future<Map<String, dynamic>> sendGetRequest(String subPath);
  
  Future<bool> sendPostRequest(String subPath, Map<String, dynamic> body);
  
  Future<bool> sendPutRequest(String subPath, Map<String, dynamic> body);

  Future<Map<String, dynamic>> sendDelRequest(String subPath);
}