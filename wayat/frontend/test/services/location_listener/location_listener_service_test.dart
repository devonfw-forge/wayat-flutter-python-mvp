import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/app_config_state/app_config_state.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/contact/contact_service.dart';
import 'package:wayat/services/location_listener/firestore_model/contact_ref_model.dart';
import 'package:wayat/services/location_listener/firestore_model/firestore_data_model.dart';
import 'package:wayat/services/location_listener/location_listener_service_impl.dart';
import 'package:wayat/services/utils/list_utils_service.dart';

import 'location_listener_service_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseFirestore>(),
  MockSpec<ContactService>(),
  MockSpec<UserState>(),
  MockSpec<HttpProvider>(),
  MockSpec<CollectionReference>(),
  MockSpec<DocumentReference>(),
  MockSpec<DocumentSnapshot>(),
  MockSpec<Stream>(),
  MockSpec<StreamSubscription>(),
])
void main() async {
  MockFirebaseFirestore mockFirestore = MockFirebaseFirestore();
  MockUserState mockUserState = MockUserState();
  MockHttpProvider mockHttpProvider = MockHttpProvider();

  setUpAll(() {
    when(mockHttpProvider.sendGetRequest("contactsRefUpdate"))
        .thenAnswer((_) async => {});
    when(mockHttpProvider.sendGetRequest("locationModeUpdate"))
        .thenAnswer((_) async => {});

    GetIt.I.registerSingleton<UserState>(mockUserState);
    GetIt.I.registerSingleton<HttpProvider>(mockHttpProvider);
  });

  test("setUpListener does not do anything if the user is null", () {
    onContactsRefUpdate(List<ContactLocation> list) =>
        mockHttpProvider.sendGetRequest("contactsRefUpdate");
    onLocationModeUpdate(bool bool) =>
        mockHttpProvider.sendGetRequest("locationModeUpdate");

    when(mockUserState.currentUser).thenReturn(null);

    LocationListenerServiceImpl locationListenerService =
        LocationListenerServiceImpl(db: mockFirestore);

    locationListenerService.setUpListener(
        onContactsRefUpdate: onContactsRefUpdate,
        onLocationModeUpdate: onLocationModeUpdate);
    verifyNever(mockHttpProvider.sendGetRequest("contactsRefUpdate"));
    verifyNever(mockHttpProvider.sendGetRequest("locationModeUpdate"));
  });

  test(
      "setUpListener makes an imperative update before setting up the listener",
      () async {
    onContactsRefUpdate(List<ContactLocation> list) =>
        mockHttpProvider.sendGetRequest("contactsRefUpdate");
    onLocationModeUpdate(bool bool) =>
        mockHttpProvider.sendGetRequest("locationModeUpdate");
    MyUser user = myUser();
    when(mockUserState.currentUser).thenReturn(user);
    MockCollectionReference<Map<String, dynamic>> mockCollectionReference =
        MockCollectionReference();
    MockDocumentReference<Map<String, dynamic>> mockDocumentReference =
        MockDocumentReference();
    MockDocumentSnapshot<Map<String, dynamic>> mockDocumentSnapshot =
        MockDocumentSnapshot();
    MockStream<DocumentSnapshot<Map<String, dynamic>>> mockStream =
        MockStream();
    when(mockFirestore.collection("status"))
        .thenReturn(mockCollectionReference);
    when(mockCollectionReference.doc(user.id))
        .thenReturn(mockDocumentReference);
    when(mockDocumentReference.get())
        .thenAnswer((_) async => mockDocumentSnapshot);
    when(mockDocumentSnapshot.data())
        .thenReturn({"active": true, "contact_refs": []});
    when(mockDocumentReference.snapshots()).thenAnswer((_) => mockStream);
    when(mockStream.listen(any)).thenReturn(MockStreamSubscription());

    LocationListenerServiceImpl locationListenerService =
        LocationListenerServiceImpl(db: mockFirestore);

    await locationListenerService.setUpListener(
        onContactsRefUpdate: onContactsRefUpdate,
        onLocationModeUpdate: onLocationModeUpdate);

    verify(mockHttpProvider.sendGetRequest("contactsRefUpdate")).called(1);
    verify(mockHttpProvider.sendGetRequest("locationModeUpdate")).called(1);
  });

  test("onStatusUpdate only calls callbacks if there is data change", () async {
    MockDocumentSnapshot<Map<String, dynamic>> mockDocumentSnapshot =
        MockDocumentSnapshot();
    when(mockDocumentSnapshot.data())
        .thenReturn({"active": true, "contact_refs": []});
    onContactsRefUpdate(List<ContactLocation> list) =>
        mockHttpProvider.sendGetRequest("contactsRefUpdate");
    onLocationModeUpdate(bool bool) =>
        mockHttpProvider.sendGetRequest("locationModeUpdate");
    MyUser user = myUser();
    when(mockUserState.currentUser).thenReturn(user);

    LocationListenerServiceImpl locationListenerService =
        LocationListenerServiceImpl(db: mockFirestore);

    locationListenerService.lastActive = true;
    locationListenerService.lastContactRefs = <ContactRefModel>[];

    await locationListenerService.onStatusUpdate(mockDocumentSnapshot,
        onContactsRefUpdate: onContactsRefUpdate,
        onLocationModeUpdate: onLocationModeUpdate);

    verifyNever(mockHttpProvider.sendGetRequest("contactsRefUpdate"));
    verifyNever(mockHttpProvider.sendGetRequest("locationModeUpdate"));
  });

  test("onStatusUpdate calls mode callback if there is data change", () async {
    MockDocumentSnapshot<Map<String, dynamic>> mockDocumentSnapshot =
        MockDocumentSnapshot();
    when(mockDocumentSnapshot.data())
        .thenReturn({"active": false, "contact_refs": []});
    onContactsRefUpdate(List<ContactLocation> list) =>
        mockHttpProvider.sendGetRequest("contactsRefUpdate");
    onLocationModeUpdate(bool bool) =>
        mockHttpProvider.sendGetRequest("locationModeUpdate");
    MyUser user = myUser();
    when(mockUserState.currentUser).thenReturn(user);

    LocationListenerServiceImpl locationListenerService =
        LocationListenerServiceImpl(db: mockFirestore);

    locationListenerService.lastActive = true;
    locationListenerService.lastContactRefs = <ContactRefModel>[];

    await locationListenerService.onStatusUpdate(mockDocumentSnapshot,
        onContactsRefUpdate: onContactsRefUpdate,
        onLocationModeUpdate: onLocationModeUpdate);

    verifyNever(mockHttpProvider.sendGetRequest("contactsRefUpdate"));
    verify(mockHttpProvider.sendGetRequest("locationModeUpdate")).called(1);
  });

  test("onStatusUpdate calls location callback if there is data change",
      () async {
    MockContactService mockContactService = MockContactService();
    when(mockContactService.getAll())
        .thenAnswer((_) async => [_contactFactory('uid')]);
    MockDocumentSnapshot<Map<String, dynamic>> mockDocumentSnapshot =
        MockDocumentSnapshot();
    when(mockDocumentSnapshot.data()).thenReturn({
      "active": true,
      "contact_refs": [
        {
          'uid': 'uid',
          'location': const GeoPoint(1.0, 1.0),
          'address': 'address',
          'last_updated': Timestamp.fromDate(DateTime(1970))
        }
      ]
    });
    onContactsRefUpdate(List<ContactLocation> list) =>
        mockHttpProvider.sendGetRequest("contactsRefUpdate");
    onLocationModeUpdate(bool bool) =>
        mockHttpProvider.sendGetRequest("locationModeUpdate");
    MyUser user = myUser();
    when(mockUserState.currentUser).thenReturn(user);

    LocationListenerServiceImpl locationListenerService =
        LocationListenerServiceImpl(db: mockFirestore);

    locationListenerService.lastActive = true;
    locationListenerService.lastContactRefs = <ContactRefModel>[];

    await locationListenerService.onStatusUpdate(mockDocumentSnapshot,
        onContactsRefUpdate: onContactsRefUpdate,
        onLocationModeUpdate: onLocationModeUpdate,
        contactService: mockContactService);

    verify(mockHttpProvider.sendGetRequest("contactsRefUpdate")).called(1);
    verifyNever(mockHttpProvider.sendGetRequest("locationModeUpdate"));
  });

  test("setUpListener does not do anything", () {
    onContactsRefUpdate(List<ContactLocation> list) =>
        mockHttpProvider.sendGetRequest("contactsRefUpdate");
    onLocationModeUpdate(bool bool) =>
        mockHttpProvider.sendGetRequest("locationModeUpdate");

    when(mockUserState.currentUser).thenReturn(null);

    LocationListenerServiceImpl locationListenerService =
        LocationListenerServiceImpl(db: mockFirestore);

    locationListenerService.setUpListener(
        onContactsRefUpdate: onContactsRefUpdate,
        onLocationModeUpdate: onLocationModeUpdate);
    verifyNever(mockHttpProvider.sendGetRequest("contactsRefUpdate"));
    verifyNever(mockHttpProvider.sendGetRequest("locationModeUpdate"));
  });

  test("getLocationModeFromStatus is correct", () {
    FirestoreDataModel data = FirestoreDataModel(active: true, contactRefs: []);
    LocationListenerServiceImpl locListenerSerrvice =
        LocationListenerServiceImpl(db: mockFirestore);
    expect(locListenerSerrvice.getLocationModeFromStatus(data), true);

    FirestoreDataModel data2 =
        FirestoreDataModel(active: false, contactRefs: []);
    expect(locListenerSerrvice.getLocationModeFromStatus(data2), false);
  });

  test("getContactRefsFromStatus returns correct contacts", () async {
    ContactService mockContactService = MockContactService();

    List<String> ids = ["id1", "id2", "id3"];
    List<ContactLocation> locatedContacts = _generateContacts(ids);
    List<Contact> contacts =
        locatedContacts.map((e) => Contact.fromMap(e.toMap())).toList();
    FirestoreDataModel data = FirestoreDataModel(
        active: true,
        contactRefs: locatedContacts
            .map((contact) => ContactRefModel(
                uid: contact.id,
                location: GeoPoint(contact.latitude, contact.longitude),
                address: contact.address,
                lastUpdated: Timestamp.fromDate(contact.lastUpdated)))
            .toList());

    when(mockContactService.getAll()).thenAnswer((_) async => contacts);

    LocationListenerServiceImpl locListenerSerrvice =
        LocationListenerServiceImpl(db: mockFirestore);

    List<ContactLocation> res = await locListenerSerrvice
        .getContactRefsFromStatus(data, contactService: mockContactService);

    expect(ListUtilsService.haveDifferentElements(res, locatedContacts), false);
  });

  test("getContactRefsFromStatus returns empty list if there is no contacts",
      () async {
    ContactService mockContactService = MockContactService();

    List<String> ids = [];
    List<ContactLocation> locatedContacts = _generateContacts(ids);
    List<Contact> contacts =
        locatedContacts.map((e) => Contact.fromMap(e.toMap())).toList();
    FirestoreDataModel data = FirestoreDataModel(
        active: true,
        contactRefs: locatedContacts
            .map((contact) => ContactRefModel(
                uid: contact.id,
                location: GeoPoint(contact.latitude, contact.longitude),
                address: contact.address,
                lastUpdated: Timestamp.fromDate(contact.lastUpdated)))
            .toList());

    when(mockContactService.getAll()).thenAnswer((_) async => contacts);

    LocationListenerServiceImpl locListenerSerrvice =
        LocationListenerServiceImpl(db: mockFirestore);

    List<ContactLocation> res = await locListenerSerrvice
        .getContactRefsFromStatus(data, contactService: mockContactService);

    expect(res, []);
  });

  test(
      "getContactRefsFromStatus returns an error message if the contacts have "
      "ERROR_ADDRESS or no address", () async {
    GetIt.I.registerSingleton<AppConfigState>(AppConfigState());
    ContactService mockContactService = MockContactService();

    List<String> ids = ["id1", "id2"];
    List<ContactLocation> locatedContacts = _generateContacts(ids);
    locatedContacts.first.address = "ERROR_ADDRESS";
    List<Contact> contacts =
        locatedContacts.map((e) => Contact.fromMap(e.toMap())).toList();
    FirestoreDataModel data = FirestoreDataModel(
        active: true,
        contactRefs: locatedContacts
            .map((contact) => ContactRefModel(
                uid: contact.id,
                location: GeoPoint(contact.latitude, contact.longitude),
                address: (contact.id == "id1") ? contact.address : null,
                lastUpdated: Timestamp.fromDate(contact.lastUpdated)))
            .toList());

    when(mockContactService.getAll()).thenAnswer((_) async => contacts);

    LocationListenerServiceImpl locListenerSerrvice =
        LocationListenerServiceImpl(db: mockFirestore);

    List<ContactLocation> res = await locListenerSerrvice
        .getContactRefsFromStatus(data, contactService: mockContactService);

    expect(res.first.address, appLocalizations.errorAddress);
    expect(res[1].address, appLocalizations.errorAddress);
  });

  test(
    "cancelListenerSubscription cancels the listener if it exists",
    () {
      MockStreamSubscription mockStreamSubscription = MockStreamSubscription();
      LocationListenerServiceImpl locListenerSerrvice =
          LocationListenerServiceImpl(db: mockFirestore);
      locListenerSerrvice.listenerSubscription = mockStreamSubscription;
      locListenerSerrvice.cancelListenerSubscription();
      verify(mockStreamSubscription.cancel()).called(1);
    },
  );

  test(
    "cancelListenerSubscription does not cancel the listener if it does not exists",
    () {
      MockStreamSubscription mockStreamSubscription = MockStreamSubscription();
      LocationListenerServiceImpl locListenerSerrvice =
          LocationListenerServiceImpl(db: mockFirestore);
      locListenerSerrvice.cancelListenerSubscription();
      verifyNever(mockStreamSubscription.cancel());
    },
  );
}

ContactLocation _contactFactory(String id) {
  return ContactLocation(
    shareLocationTo: true,
    id: id,
    name: "contact $id",
    email: "Contact email",
    imageUrl: "https://example.com/image",
    phone: "123",
    address: '',
    lastUpdated: DateTime.now(),
    latitude: 1,
    longitude: 1,
  );
}

MyUser myUser() => MyUser(
    email: 'email',
    name: 'name',
    id: 'id',
    imageUrl: 'imageUrl',
    phone: 'phone',
    phonePrefix: 'prefix',
    onboardingCompleted: true,
    shareLocationEnabled: true);

List<ContactLocation> _generateContacts(List<String> ids) {
  return ids.map((id) => _contactFactory(id)).toList();
}
