import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/common/app_config/env_model.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/services/authentication/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:wayat/services/contact/contact_service.dart';
import 'package:wayat/services/contact/contact_service_impl.dart';
import 'package:wayat/services/location_listener/firestore_model/contact_ref_model.dart';
import 'package:wayat/services/location_listener/location_listener_service.dart';

class FiredartListenerServiceImpl extends LocationListenerService {
  @visibleForTesting
  late bool lastActive;
  @visibleForTesting
  late List lastContactRefs;

  final String firestoreURL =
      "https://firestore.googleapis.com/v1/projects/${EnvModel.PROJECT_ID}/databases/(default)/documents/status";

  /// Subscription for the listener to status doc in Firestore
  StreamSubscription? listenerSubscription;

  Stream? stream;

  ///SetUp listener of contactLocation mode update from status
  @override
  Future<void> setUpListener(
      {required Function(List<ContactLocation>) onContactsRefUpdate,
      required Function(bool) onLocationModeUpdate}) async {
    if (GetIt.I.get<UserState>().currentUser == null) {
      return;
    }

    List<ContactLocation> contacts =
        await contactRefsToContactLocations(await getContactRefs());
    // Update contactRef before listenings
    onContactsRefUpdate(contacts);

    stream =
        Stream.periodic(const Duration(seconds: 30), (_) async {
      return await contactRefsToContactLocations(await getContactRefs());
    });

    listenerSubscription = stream!.listen((contacts) async {
      await onContactsRefUpdate(await contacts);
    }, onError: (error) => log("[ERROR] Firestore listen failed: $error"));
  }

  Future<List<ContactRefModel>> getContactRefs() async {
    Uri url =
        Uri.parse("$firestoreURL/${GetIt.I.get<UserState>().currentUser!.id}");
    http.Response resultJson =
        await http.Client().get(url, headers: await getHeaders());
    Map<String, dynamic> response =
        json.decode(const Utf8Decoder().convert(resultJson.bodyBytes))
            as Map<String, dynamic>;
    List<ContactRefModel> contactRefs = [];
    final values = response["fields"]["contact_refs"]["arrayValue"]["values"];
    if (values != null) {
      // Do mapping:
      for (dynamic value in (values as List)) {
        final contactRef = value['mapValue']["fields"];
        contactRefs.add(ContactRefModel(
          uid: contactRef["uid"]["stringValue"],
          location: GeoPoint(
              contactRef["location"]["geoPointValue"]["latitude"],
              contactRef["location"]["geoPointValue"]["longitude"]),
          address: contactRef["address"]["stringValue"],
          lastUpdated: Timestamp.fromDate(DateTime.parse(
              contactRef["last_updated"]["timestampValue"].toString())),
        ));
      }
    }
    return contactRefs;
  }

  @override
  void cancelListenerSubscription() {
    if (listenerSubscription != null) {
      listenerSubscription!.pause();
      listenerSubscription!.cancel();
    }
  }

  /// Returns the necessary content and authentication headers for all server requests.
  @visibleForTesting
  Future<Map<String, String>> getHeaders() async {
    AuthService authService = GetIt.I.get<UserState>().authService;
    return {
      "Content-Type": ContentType.json.toString(),
      "Authorization": "Bearer ${await authService.getIdToken()}"
    };
  }

  @visibleForTesting
  Future<List<ContactLocation>> contactRefsToContactLocations(
      List<ContactRefModel> contactRefs,
      {ContactService? contactService}) async {
    ContactService service = contactService ?? ContactServiceImpl();
    List<Contact> contacts = await service.getAll();

    if (contactRefs.isNotEmpty) {
      List<ContactLocation> contactLocations = contactRefs.map((e) {
        Contact contact = contacts.firstWhere((contact) => contact.id == e.uid);
        String address = e.address ?? "ERROR_ADDRESS";
        if (address == "ERROR_ADDRESS") {
          address = appLocalizations.errorAddress;
        }
        ContactLocation located = ContactLocation(
            shareLocationTo: contact.shareLocationTo,
            id: contact.id,
            name: contact.name,
            email: contact.email,
            imageUrl: contact.imageUrl,
            phone: contact.phone,
            latitude: e.location.latitude,
            longitude: e.location.longitude,
            address: address,
            lastUpdated: e.lastUpdated.toDate());
        return located;
      }).toList();
      return contactLocations;
    }
    return [];
  }
}
