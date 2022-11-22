import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/services/contact/contact_service.dart';
import 'package:wayat/services/location_listener/firedart/firedart_listener_service.dart';
import 'package:firedart/firedart.dart';
import 'package:wayat/services/location_listener/firestore_model/firestore_data_model.dart';

class FiredartListenerServiceImpl extends FiredartListenerService {

  @visibleForTesting
  late bool lastActive;
  @visibleForTesting
  late List lastContactRefs;

  /// Subscription for the listener to status doc in Firestore
  StreamSubscription? listenerSubscription;

  ///SetUp listener of contactLocation mode update from status
  @override
  Future<void> setUpListener(
      {required Function(List<ContactLocation>) onContactsRefUpdate,
      required Function(bool) onLocationModeUpdate}) async {
    if (GetIt.I.get<UserState>().currentUser == null) {
      return;
    }
    final docRef
 = Firestore.instance.collection('status').document(GetIt.I.get<UserState>().currentUser!.id);
    print('DEBUG '+docRef.toString());
    FirestoreDataModel firestoreData =
        FirestoreDataModel.fromMap((await docRef.get()).data()!);
    lastActive = firestoreData.active;
    lastContactRefs = firestoreData.contactRefs;
    // Update locationMode before listening
    onLocationModeUpdate(getLocationModeFromStatus(firestoreData));
    // Update contactRef before listenings
    onContactsRefUpdate(await getContactRefsFromStatus(firestoreData));

    // Subscribe to changes in the currentUser status document
    listenerSubscription = docRef.snapshots().listen(
      (event) async {
        await onStatusUpdate(event,
            onLocationModeUpdate: onLocationModeUpdate,
            onContactsRefUpdate: onContactsRefUpdate);
      },
      onError: (error) => log("[ERROR] Firestore listen failed: $error"),
    );
  }

  @override
  void cancelListenerSubscription() {
    // TODO: implement cancelListenerSubscription
  }

  @override
  Future<List<ContactLocation>> getContactRefsFromStatus(FirestoreDataModel firestoreData, {ContactService? contactService}) {
    // TODO: implement getContactRefsFromStatus
    throw UnimplementedError();
  }

  @override
  bool getLocationModeFromStatus(FirestoreDataModel firestoreData) {
    // TODO: implement getLocationModeFromStatus
    throw UnimplementedError();
  }

  @override
  Future<void> onStatusUpdate(DocumentSnapshot<Map<String, dynamic>> event, {required Function(List<ContactLocation> p1) onContactsRefUpdate, required Function(bool p1) onLocationModeUpdate, ContactService? contactService}) {
    // TODO: implement onStatusUpdate
    throw UnimplementedError();
  }

  // @override
  // Future<void> onStatusUpdate(DocumentSnapshot<Map<String, dynamic>> event,
  //     {required Function(List<ContactLocation>) onContactsRefUpdate,
  //     required Function(bool) onLocationModeUpdate,
  //     ContactService? contactService}) async {
  //   FirestoreDataModel updatedData = FirestoreDataModel.fromMap(event.data()!);

  //   if ((updatedData.active) != lastActive) {
  //     onLocationModeUpdate(getLocationModeFromStatus(updatedData));
  //     lastActive = updatedData.active;
  //   }
  //   if (ListUtilsService.haveDifferentElements(
  //       updatedData.contactRefs, lastContactRefs)) {
  //     onContactsRefUpdate(await getContactRefsFromStatus(updatedData,
  //         contactService: contactService));
  //     lastContactRefs = updatedData.contactRefs;
  //   }
  // }

  // /// Closes current listener to Firestore
  // @override
  // void cancelListenerSubscription() {
  //   if (listenerSubscription != null) {
  //     listenerSubscription!.cancel();
  //   }
  // }

  // /// Return active or passive location mode from Firestore status
  // @override
  // @visibleForTesting
  // bool getLocationModeFromStatus(FirestoreDataModel firestoreData) {
  //   return firestoreData.active;
  // }

  // ///Return [ContactLocation]
  // ///
  // ///Get contact uid, location, address and last updated data
  // @override
  // @visibleForTesting
  // Future<List<ContactLocation>> getContactRefsFromStatus(
  //     FirestoreDataModel firestoreData,
  //     {ContactService? contactService}) async {
  //   ContactService service = contactService ?? ContactServiceImpl();
  //   List<Contact> contacts = await service.getAll();

  //   List<ContactRefModel> contactRefs = firestoreData.contactRefs;
  //   if (contactRefs.isNotEmpty) {
  //     List<ContactLocation> contactLocations = contactRefs.map((e) {
  //       Contact contact = contacts.firstWhere((contact) => contact.id == e.uid);
  //       String address = e.address ?? "ERROR_ADDRESS";
  //       if (address == "ERROR_ADDRESS") {
  //         address = appLocalizations.errorAddress;
  //       }
  //       ContactLocation located = ContactLocation(
  //           shareLocationTo: contact.shareLocationTo,
  //           id: contact.id,
  //           name: contact.name,
  //           email: contact.email,
  //           imageUrl: contact.imageUrl,
  //           phone: contact.phone,
  //           latitude: e.location.latitude,
  //           longitude: e.location.longitude,
  //           address: address,
  //           lastUpdated: e.lastUpdated.toDate());
  //       return located;
  //     }).toList();
  //     return contactLocations;
  //   }
  //   return [];
  // }
}
