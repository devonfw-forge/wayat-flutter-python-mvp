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
  void setUpContactsListener(Function onContactsUpdate) {
    final docRef = db.collection("status").doc("7cQMpsydsfeyIVhmQO3RJaHkwJA2");
    docRef.snapshots().listen(
          (event) => debugPrint(event.data().toString()),
          onError: (error) => print("Listen failed: $error"),
        );
  }
}
