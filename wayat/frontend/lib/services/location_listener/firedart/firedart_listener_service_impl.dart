import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/common/app_config/env_model.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/services/contact/contact_service.dart';
import 'package:firedart/firedart.dart';
import 'package:wayat/services/location_listener/firestore_model/firestore_data_model.dart';
import 'package:wayat/services/location_listener/location_listener_service.dart';

class FiredartListenerServiceImpl extends LocationListenerService {

  @visibleForTesting
  late bool lastActive;
  @visibleForTesting
  late List lastContactRefs;

  final Firestore db;

  FiredartListenerServiceImpl({Firestore? db})
      : db = db ?? Firestore.instance;

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
 = db.collection('status').document(GetIt.I.get<UserState>().currentUser!.id);

    FirestoreDataModel firestoreData =
        FirestoreDataModel.fromMap((await docRef.get()).map);

        // print('DEBUG FD: '+firestoreData.toString());
    lastActive = firestoreData.active;
    lastContactRefs = firestoreData.contactRefs;
    // Update locationMode before listening
    onLocationModeUpdate(getLocationModeFromStatus(firestoreData));
    // Update contactRef before listenings
    onContactsRefUpdate(await getContactRefsFromStatus(firestoreData));

    docRef.stream.listen((document) async {
        await onStatusUpdate(document!.map,
            onLocationModeUpdate: onLocationModeUpdate,
            onContactsRefUpdate: onContactsRefUpdate);
    }, onError: (error) => log("[ERROR] Firestore listen failed: $error"));
  }

  @override
  void cancelListenerSubscription() {
    if (listenerSubscription != null) {
      listenerSubscription!.cancel();
    }
  }

  @override
  Future<List<ContactLocation>> getContactRefsFromStatus(FirestoreDataModel firestoreData, {ContactService? contactService}) {
    // TODO: implement getContactRefsFromStatus
    throw UnimplementedError();
  }

  @override
  bool getLocationModeFromStatus(FirestoreDataModel firestoreData) {
    return firestoreData.active;
  }

  @override
  Future<void> onStatusUpdate(event, {required Function(List<ContactLocation> p1) onContactsRefUpdate, required Function(bool p1) onLocationModeUpdate, ContactService? contactService}) {
    // TODO: implement onStatusUpdate
    throw UnimplementedError();
  }
}
