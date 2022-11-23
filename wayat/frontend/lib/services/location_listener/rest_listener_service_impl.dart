import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/common/app_config/env_model.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/services/authentication/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:wayat/services/contact/contact_service.dart';
import 'package:wayat/services/location_listener/firestore_model/contact_ref_model.dart';
import 'package:wayat/services/location_listener/firestore_model/firestore_data_model.dart';
import 'package:wayat/services/location_listener/location_listener_service.dart';

class FiredartListenerServiceImpl extends LocationListenerService {

  @visibleForTesting
  late bool lastActive;
  @visibleForTesting
  late List lastContactRefs;

  final String firestoreURL = "https://firestore.googleapis.com/v1/projects/${EnvModel.PROJECT_ID}/databases/(default)/documents/status";


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


    print('DEBUG ${(await getContactRefs()).toString()}');


    // lastActive = firestoreData.active;
    // lastContactRefs = firestoreData.contactRefs;
    // // Update locationMode before listening
    // onLocationModeUpdate(getLocationModeFromStatus(firestoreData));
    // // Update contactRef before listenings
    // onContactsRefUpdate(await getContactRefsFromStatus(firestoreData));

    // docRef.stream.listen((document) async {
    //     await onStatusUpdate(document!.map,
    //         onLocationModeUpdate: onLocationModeUpdate,
    //         onContactsRefUpdate: onContactsRefUpdate);
    // }, onError: (error) => log("[ERROR] Firestore listen failed: $error"));
    
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
      Future<void> onStatusUpdate(event, {required Function(List<ContactLocation> p1) onContactsRefUpdate, required Function(bool p1) onLocationModeUpdate, ContactService? contactService}) {
    // TODO: implement onStatusUpdate
    throw UnimplementedError();
      }
    
      @override
      Future<void> setUpListener({required Function(List<ContactLocation> p1) onContactsRefUpdate, required Function(bool p1) onLocationModeUpdate}) {
    // TODO: implement setUpListener
    throw UnimplementedError();
      }
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

  Future<List<ContactRefModel>> getContactRefs() async {

    final Map<String,String> headers = await getHeaders();

    AuthService authService = GetIt.I.get<UserState>().authService;

    Uri url = Uri.parse(
        "$firestoreURL/${GetIt.I.get<UserState>().currentUser!.id}");

    http.Response resultJson =
          await http.Client().get(url, headers: headers);
      Map<String, dynamic> response =  json.decode(const Utf8Decoder().convert(resultJson.bodyBytes))
          as Map<String, dynamic>;


      List<ContactRefModel> contactRefs = [];
      final values = response["fields"]["contact_refs"]["arrayValue"]["values"];
      for (dynamic value in (values as List)) {
        final contactRef = value['mapValue']["fields"];
        contactRefs.add(ContactRefModel(
          uid: contactRef["uid"]["stringValue"],
          location: GeoPoint(
            contactRef["location"]["geoPointValue"]["latitude"],
            contactRef["location"]["geoPointValue"]["longitude"]
          ),
          address: contactRef["address"]["stringValue"],
          lastUpdated: Timestamp.fromDate(DateFormat('yyyy-MM-ddThh:mm')
              .parse(contactRef["last_updated"]["timestampValue"].toString())),
        ));
      }
      return contactRefs;
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

}


