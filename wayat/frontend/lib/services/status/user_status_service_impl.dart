import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/location_state/share_mode.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/services/contact/contact_service.dart';
import 'package:wayat/services/contact/contact_service_impl.dart';

class UserStatusService {
  final FirebaseFirestore db;

  UserStatusService({FirebaseFirestore? db})
      : db = db ?? FirebaseFirestore.instanceFor(app: Firebase.app('WAYAT'));

  late bool _lastActive;
  late List _lastContactRefs;

  Future setUpListener(
      {required Function(List<ContactLocation>) onContactsRefUpdate,
      required Function(ShareLocationMode) onLocationModeUpdate}) async {
    if (GetIt.I.get<SessionState>().currentUser == null) {
      return;
    }
    final docRef = db
        .collection("status")
        .doc(GetIt.I.get<SessionState>().currentUser!.id);

    Map<String, dynamic> firestoreData = (await docRef.get()).data()!;
    _lastActive = firestoreData["active"] as bool;
    _lastContactRefs = firestoreData["contact_refs"] as List;
    // Update locationMode before listening
    onLocationModeUpdate(getLocationModeFromStatus(firestoreData));
    // Update contactRef before listenings
    onContactsRefUpdate(await getContactRefsFromStatus(firestoreData));

    // Subscribe to changes in tshe currentUser status document
    docRef.snapshots().listen(
      (event) async {
        if ((event.data()!["active"] as bool) != _lastActive) {
          onLocationModeUpdate(getLocationModeFromStatus(event.data()!));
          _lastActive = event.data()!["active"] as bool;
        }
        if ((event.data()!["contact_refs"] as List) != _lastContactRefs) {
          onContactsRefUpdate(await getContactRefsFromStatus(event.data()!));
          _lastContactRefs = firestoreData["contact_refs"] as List;
        }
      },
      //onError: (error) => debugPrint("[ERROR] Listen failed: $error"),
    );
  }

  @visibleForTesting
  ShareLocationMode getLocationModeFromStatus(
      Map<String, dynamic> firestoreData) {
    if (firestoreData["active"] as bool) {
      return ShareLocationMode.active;
    }
    return ShareLocationMode.passive;
  }

  @visibleForTesting
  Future<List<ContactLocation>> getContactRefsFromStatus(
      Map<String, dynamic> firestoreData,
      {ContactService? contactService}) async {
    ContactService service = contactService ?? ContactServiceImpl();
    List<Contact> contacts = await service.getAll();

    List contactRefs = firestoreData["contact_refs"] as List;
    if (contactRefs.isNotEmpty) {
      List<ContactLocation> contactLocations = contactRefs.map((e) {
        Contact contact =
            contacts.firstWhere((contact) => contact.id == e["uid"]);
        GeoPoint loc = e["location"];
        String address = e["address"] ?? "ERROR_ADDRESS";
        if (address == "ERROR_ADDRESS") {
          address = appLocalizations.errorAddress;
        }
        Timestamp lastUpdated = e["last_updated"];
        ContactLocation located = ContactLocation(
            available: true,
            shareLocation: contact.shareLocation,
            id: contact.id,
            name: contact.name,
            email: contact.email,
            imageUrl: contact.imageUrl,
            phone: contact.phone,
            latitude: loc.latitude,
            longitude: loc.longitude,
            address: address,
            lastUpdated: lastUpdated.toDate());
        return located;
      }).toList();
      return contactLocations;
    }
    return [];
  }
}
