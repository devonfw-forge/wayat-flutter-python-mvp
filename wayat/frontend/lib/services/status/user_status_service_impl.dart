import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/location_state/share_mode.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/services/contact/contact_service_impl.dart';

class UserStatusService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  
  void setUpListener({
      required Function(List<ContactLocation>) onContactsRefUpdate,
      required Function(ShareLocationMode) onLocationModeUpdate
    }) async {
    
    final docRef = db
        .collection("status")
        .doc(GetIt.I.get<SessionState>().currentUser!.id);
    
    // Update contactRef before listenings
    onContactsRefUpdate(
        await _getUsersFromContactRefs((await docRef.get()).data()!));
    
    // Subscribe to changes in the currentUser status document
    docRef.snapshots().listen(
      (event) async {
        // TODO Add onLocationModeUpdate, it should be checked if changed data corresponds to ContactRef or LocationMode
        onContactsRefUpdate(await _getUsersFromContactRefs(event.data()!));
      },
      onError: (error) => debugPrint("Listen failed: $error"),
    );
  }

  Future<List<ContactLocation>> _getUsersFromContactRefs(
      Map<String, dynamic> firestoreData) async {
    
    List<Contact> contacts = await ContactServiceImpl().getAll();

    if ((firestoreData["contact_refs"] as List).isNotEmpty) {
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

      return contactLocations;
    }
    return [];
  }
}