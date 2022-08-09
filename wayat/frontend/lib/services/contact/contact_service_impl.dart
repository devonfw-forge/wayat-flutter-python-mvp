import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:wayat/app_state/contacts_location/contacts_location_state.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/contact/contact_address_book.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/features/contacts/controller/contact_controller.dart';
import 'package:wayat/services/contact/contact_service.dart';
import 'package:wayat/services/contact/mock/contacts_mock.dart';

class ContactServiceImpl extends ContactService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

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
    print("SENDD: ${{"users": contacts.map((e) => e.id).toList()}}");
    Response res = await super.sendPostRequest(
        "users/add-contact", {"users": contacts.map((e) => e.id).toList()});
    print("RESSS: ${res.statusCode} ${res.body}");
  }

  @override
  Future<List<Contact>> getFilteredContacts(
      List<ContactAdressBook> importedContacts) async {
    List<String> phoneList =
        importedContacts.map((e) => e.phoneNumber.replaceAll(' ', '')).toList();

    //super.sendPostRequest("/users/find-by-phone", bod)
    print("LIST: $phoneList");
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
    final docRef =
        db.collection("status").doc(GetIt.I.get<SessionState>().currentUser.id);
    _getUsersFromContactRefs((await docRef.get()).data()!);
    docRef.snapshots().listen(
          (event) => _getUsersFromContactRefs(event.data()!),
          onError: (error) => print("Listen failed: $error"),
        );
    debugPrint("Listener set up");
  }

  void _getUsersFromContactRefs(Map<String, dynamic> firestoreData) async {
    List<Contact> contacts = await getAll();
    print(firestoreData);
    List<ContactLocation> contactLocations =
        (firestoreData["contact_refs"] as List).map((e) {
      Contact contact =
          contacts.firstWhere((contact) => contact.id == e["uid"]);
      GeoPoint loc = e["location"];
      Timestamp lastUpdated = e["last_updated"];
      ContactLocation located = ContactLocation(
          available: true,
          id: contact.id,
          name: contact.name,
          email: contact.name,
          imageUrl: contact.imageUrl,
          phone: contact.phone,
          latitude: loc.latitude,
          longitude: loc.longitude,
          lastUpdated: lastUpdated.toDate());
      return located;
    }).toList();

    GetIt.I.get<ContactsLocationState>().setContactList(contactLocations);
  }
}
