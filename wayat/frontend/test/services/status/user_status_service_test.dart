import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/location_state/share_mode.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:wayat/services/contact/contact_service.dart';
import 'package:wayat/services/status/user_status_service_impl.dart';
import 'package:wayat/services/utils/list_utils_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'user_status_service_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseFirestore>(),
  MockSpec<ContactService>(),
  MockSpec<SessionState>(),
])
void main() async {
  MockFirebaseFirestore mockFirestore = MockFirebaseFirestore();

  setUpAll(() {
    GetIt.I.registerSingleton(LangSingleton());
  });

  test("getLocationModeFromStatus is correct", () {
    Map<String, dynamic> data = {"active": true};
    UserStatusService statusService = UserStatusService(db: mockFirestore);
    expect(statusService.getLocationModeFromStatus(data),
        ShareLocationMode.active);
    data["active"] = false;
    expect(statusService.getLocationModeFromStatus(data),
        ShareLocationMode.passive);
  });

  test("getContactRefsFromStatus returns correct contacts", () async {
    ContactService mockContactService = MockContactService();

    List<String> ids = ["id1", "id2", "id3"];
    List<ContactLocation> locatedContacts = _generateContacts(ids);
    List<Contact> contacts =
        locatedContacts.map((e) => Contact.fromMap(e.toMap())).toList();
    Map<String, dynamic> data = {
      "contact_refs": locatedContacts
          .map((contact) => {
                "uid": contact.id,
                "location": GeoPoint(contact.latitude, contact.longitude),
                "address": contact.address,
                "last_updated": Timestamp.fromDate(contact.lastUpdated)
              })
          .toList()
    };

    when(mockContactService.getAll()).thenAnswer((_) async => contacts);

    UserStatusService statusService = UserStatusService(db: mockFirestore);

    List<ContactLocation> res = await statusService
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
    Map<String, dynamic> data = {
      "contact_refs": locatedContacts
          .map((contact) => {
                "uid": contact.id,
                "location": GeoPoint(contact.latitude, contact.longitude),
                "address": contact.address,
                "last_updated": Timestamp.fromDate(contact.lastUpdated)
              })
          .toList()
    };

    when(mockContactService.getAll()).thenAnswer((_) async => contacts);

    UserStatusService statusService = UserStatusService(db: mockFirestore);

    List<ContactLocation> res = await statusService
        .getContactRefsFromStatus(data, contactService: mockContactService);

    expect(res, []);
  });

  testWidgets(
      "getContactRefsFromStatus returns an error message if the contacts have "
      "ERROR_ADDRESS or no address", (tester) async {
    await tester.pumpWidget(_createApp());

    ContactService mockContactService = MockContactService();

    List<String> ids = ["id1", "id2"];
    List<ContactLocation> locatedContacts = _generateContacts(ids);
    locatedContacts.first.address = "ERROR_ADDRESS";
    List<Contact> contacts =
        locatedContacts.map((e) => Contact.fromMap(e.toMap())).toList();
    Map<String, dynamic> data = {
      "contact_refs": locatedContacts
          .map((contact) => {
                "uid": contact.id,
                "location": GeoPoint(contact.latitude, contact.longitude),
                "address": (contact.id == "id1") ? contact.address : null,
                "last_updated": Timestamp.fromDate(contact.lastUpdated)
              })
          .toList()
    };

    when(mockContactService.getAll()).thenAnswer((_) async => contacts);

    UserStatusService statusService = UserStatusService(db: mockFirestore);

    List<ContactLocation> res = await statusService
        .getContactRefsFromStatus(data, contactService: mockContactService);

    expect(res.first.address, appLocalizations.errorAddress);
    expect(res[1].address, appLocalizations.errorAddress);
  });
}

ContactLocation _contactFactory(String id) {
  return ContactLocation(
    shareLocation: true,
    available: true,
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

List<ContactLocation> _generateContacts(List<String> ids) {
  return ids.map((id) => _contactFactory(id)).toList();
}

Widget _createApp() {
  return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    onGenerateTitle: (context) {
      GetIt.I.get<LangSingleton>().initialize(context);
      return GetIt.I.get<LangSingleton>().appLocalizations.appTitle;
    },
  );
}
