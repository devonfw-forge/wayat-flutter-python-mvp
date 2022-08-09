import 'dart:convert';

import 'package:http/http.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/contact/contact_address_book.dart';
import 'package:wayat/services/contact/contact_service.dart';
import 'package:wayat/services/contact/mock/contacts_mock.dart';

class ContactServiceImpl extends ContactService {
  @override
  List<Contact> getAll() {
    return ContactsMock.contacts;
  }

  @override
  void sendRequests(List<Contact> contacts) {
    super.sendPostRequest(
        "users/add-contact", {"users": contacts.map((e) => e.id).toList()});
  }

  @override
  Future<List<Contact>> getFilteredContacts(
      List<ContactAdressBook> importedContacts) async {
    List<String> phoneList =
        importedContacts.map((e) => e.phoneNumber).toList();

    //super.sendPostRequest("/users/find-by-phone", bod)
    Response response = await super
        .sendPostRequest("users/find-by-phone", {"phones": phoneList});
    Map<String, dynamic> jsonBody = jsonDecode(response.body);
    List<Contact> contactList = (jsonBody["users"] as List<dynamic>)
        .map((e) => Contact.fromMap(e))
        .toList();

    print("FILTERED CONTACTS $contactList");

    return contactList;
  }
}
