import 'dart:convert';
import 'package:http/http.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/contact/contact_address_book.dart';
import 'package:wayat/services/contact/contact_service.dart';

class ContactServiceImpl extends ContactService {
  @override
  Future<List<Contact>> getAll() async {
    Map<String, dynamic> response = await sendGetRequest("users/contacts");
    List<Contact> contacts = (response["users"] as List<dynamic>)
        .map((e) => Contact.fromMap(e))
        .toList();
    return contacts;
  }

  @override
  Future<void> sendRequests(List<Contact> contacts) async {
    await super.sendPostRequest(
        "users/add-contact", {"users": contacts.map((e) => e.id).toList()});
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
        .sendPostRequest("users/find-by-phone", {"phones": phoneList});
    Map<String, dynamic> jsonBody =
        jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
    List<Contact> contactList = (jsonBody["users"] as List<dynamic>)
        .map((e) => Contact.fromMap(e))
        .toList();

    return contactList;
  }

  @override
  Future<bool> removeContact(Contact contact) async {
    return await super.sendDelRequest("users/contacts/${contact.id}");
  }
}
