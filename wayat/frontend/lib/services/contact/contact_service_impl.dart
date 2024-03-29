import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/services/common/api_contract/api_contract.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/contact/contact_service.dart';

/// Implementation of the [ContactService] interface
class ContactServiceImpl implements ContactService {
  /// Makes the HTTP calls for the service.
  final HttpProvider httpProvider = GetIt.I.get<HttpProvider>();

  @override
  Future<List<Contact>> getAll() async {
    Map<String, dynamic> response =
        await httpProvider.sendGetRequest(APIContract.contacts);
    if (response["users"] == null) return [];
    List<Contact> contacts = (response["users"] as List<dynamic>)
        .map((e) => Contact.fromMap(e))
        .toList();
    return contacts;
  }

  @override
  Future<void> sendRequests(List<Contact> contacts) async {
    await httpProvider.sendPostRequest(
        APIContract.addContact, {"users": contacts.map((e) => e.id).toList()});
  }

  @override
  Future<List<Contact>> getFilteredContacts(
      List<String> importedContacts) async {
    Response response = await httpProvider
        .sendPostRequest(APIContract.findByPhone, {"phones": importedContacts});
    Map<String, dynamic> jsonBody =
        jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
    List<Contact> contactList = (jsonBody["users"] as List<dynamic>)
        .map((e) => Contact.fromMap(e))
        .toList();

    return contactList;
  }

  @override
  Future<bool> removeContact(Contact contact) async {
    return await httpProvider
        .sendDelRequest("${APIContract.contacts}/${contact.id}");
  }
}
