import 'package:wayat/domain/contact/contact.dart';

abstract class RequestsService {
  Future<Map<String, List<Contact>>> getRequests();
  Future<bool> acceptRequest(Contact contact);
  Future<bool> rejectRequest(Contact contact);
  Future<bool> sendRequest(Contact contact);
  Future<bool> sendRequests(List<Contact> contacts);
  Future<bool> unsendRequest(Contact contact);
}
