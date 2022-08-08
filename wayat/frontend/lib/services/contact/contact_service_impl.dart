import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/services/contact/contact_service.dart';
import 'package:wayat/services/contact/mock/contacts_mock.dart';

class ContactServiceImpl extends ContactService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  List<Contact> getAll() {
    return ContactsMock.contacts;
  }

  @override
  void sendRequests(List<Contact> contacts) {
    //TODO: SEND REQUESTS TO BACKEND
  }

  @override
  void setUpContactsListener(Function onContactsUpdate) async {
    debugPrint("Setting up contacts listener");
    final docRef = db.collection("status").doc("7cQMpsydsfeyIVhmQO3RJaHkwJA2");
    final docData = await docRef.get();
    //print("Imperative " + docData.data()!["active"].toString());
    docRef.snapshots().listen(
          (event) => debugPrint("Listener ${event.data()}"),
          onError: (error) => print("Listen failed: $error"),
        );
    debugPrint("Listener set up");
  }
}
