import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/services/request/rest_service.dart';

abstract class RequestsService extends RESTService {
  Future<Map<String, List<Contact>>> getRequests();
  Future acceptRequest(Contact contact);
  Future rejectRequest(Contact contact);
  Future sendRequest(Contact contact);
  Future sendRequests(List<Contact> contacts);
  Future unsendRequest(Contact contact);
}
