import 'dart:convert';
import 'package:http/http.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/services/api_contract/api_contract.dart';
import 'package:wayat/services/contact/contact_service.dart';

class ContactServiceImpl extends ContactService {
  @override
  Future<List<Contact>> getAll() async {
    Map<String, dynamic> response = await sendGetRequest(APIContract.contacts);
    List<Contact> contacts = (response["users"] as List<dynamic>)
        .map((e) => Contact.fromMap(e))
        .toList();
    return contacts;
  }

  @override
  Future<void> sendRequests(List<Contact> contacts) async {
    await super.sendPostRequest(
        APIContract.addContact, {"users": contacts.map((e) => e.id).toList()});
  }

  @override
  Future<List<Contact>> getFilteredContacts(
      List<String> importedContacts) async {
    List<String> phoneList = importedContacts
        .map((e) => e
            .replaceAll(' ', '')
            .replaceAll('-', '')
            .replaceAll('(', '')
            .replaceAll(')', ''))
        .toList();

    Response response = await super
        .sendPostRequest(APIContract.findByPhone, {"phones": phoneList});
    Map<String, dynamic> jsonBody =
        jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
    List<Contact> contactList = (jsonBody["users"] as List<dynamic>)
        .map((e) => Contact.fromMap(e))
        .toList();

    return contactList;
  }

  @override
  Future<bool> removeContact(Contact contact) async {
    return await super.sendDelRequest("${APIContract.contacts}/${contact.id}");
  }
}
