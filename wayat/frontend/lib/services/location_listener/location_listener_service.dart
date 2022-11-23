import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/services/contact/contact_service.dart';
import 'package:wayat/services/location_listener/firestore_model/firestore_data_model.dart';

abstract class LocationListenerService {

  ///SetUp listener of contactLocation mode update from status
  Future<void> setUpListener(
      {required Function(List<ContactLocation>) onContactsRefUpdate,
      required Function(bool) onLocationModeUpdate});

  Future<void> onStatusUpdate(event,
      {required Function(List<ContactLocation>) onContactsRefUpdate,
      required Function(bool) onLocationModeUpdate,
      ContactService? contactService});

  /// Closes current listener to Firestore
  void cancelListenerSubscription();

  /// Return active or passive location mode from Firestore status
  @visibleForTesting
  bool getLocationModeFromStatus(FirestoreDataModel firestoreData);

  ///Return [ContactLocation]
  ///
  ///Get contact uid, location, address and last updated data
  @visibleForTesting
  Future<List<ContactLocation>> getContactRefsFromStatus(
      FirestoreDataModel firestoreData,
      {ContactService? contactService});
}
