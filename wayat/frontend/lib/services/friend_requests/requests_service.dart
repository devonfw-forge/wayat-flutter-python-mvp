import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/services/request/rest_service.dart';

abstract class RequestsService extends RESTService {
  Future<Map<String, List<Contact>>> getRequests();
  Future<bool> acceptRequest(Contact contact);
  Future<bool> rejectRequest(Contact contact);
  Future<bool> sendRequest(Contact contact);
  Future<bool> sendRequests(List<Contact> contacts);
  Future<bool> unsendRequest(Contact contact);
}
