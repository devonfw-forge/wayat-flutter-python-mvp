import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:wayat/app_state/contacts_location/contacts_location_state.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/contact/contact_address_book.dart';
import 'package:wayat/services/contact/contact_service.dart';
import 'package:wayat/services/contact/mock/contacts_mock.dart';

class ContactServiceImpl extends ContactService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  ContactsLocationState contactsLocationState =
      GetIt.I.get<ContactsLocationState>();

  @override
  Future<List<Contact>> getAll() async {
    Map<String, dynamic> response = await sendGetRequest("users/contacts");
    List<Contact> contacts = (response["users"] as List<dynamic>)
        .map((e) => Contact.fromMap(e))
        .toList();
    return contacts;
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

  @override
  void setUpContactsListener(Function onContactsUpdate) async {
    debugPrint("Setting up contacts listener");
    final docRef = db.collection("status").doc("7cQMpsydsfeyIVhmQO3RJaHkwJA2");
    final docData = await docRef.get();
    docRef.snapshots().listen(
          (event) => _getUsersFromContactRefs(event.data()!),
          onError: (error) => print("Listen failed: $error"),
        );
    debugPrint("Listener set up");
  }

  void _getUsersFromContactRefs(Map<String, dynamic> firestoreData) async {
    List<Contact> contacts = await getAll();
    //TODO: BUILD CONTACT LOCATION LIST WITH FIRESTORE DATA AND CONTACT LIST USING THE IDS
  }
}
