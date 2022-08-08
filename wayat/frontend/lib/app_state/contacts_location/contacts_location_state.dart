import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/services/contact/contact_service.dart';
import 'package:wayat/services/contact/contact_service_impl.dart';

part 'contacts_location_state.g.dart';

class ContactsLocationState = _ContactsLocationState
    with _$ContactsLocationState;

abstract class _ContactsLocationState with Store {
  ContactService contactService = ContactServiceImpl();

  _ContactsLocationState() {
    contactService.setUpContactsListener(setContactList);
  }

  @observable
  List<ContactLocation> contacts = [];

  @action
  void setContactList(List<ContactLocation> newContacts) {
    contacts = newContacts;
  }

  void fetchContacts() {}
}
