import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/contact/contact_service.dart';
import 'package:wayat/services/location_listener/firestore_model/contact_ref_model.dart';
import 'package:wayat/services/location_listener/rest_listener_service_impl.dart';

import 'rest_listener_service_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<UserState>(),
  MockSpec<HttpProvider>(),
  MockSpec<ContactService>()
  ])
void main() async {
  MockUserState mockUserState = MockUserState();
  MockHttpProvider mockHttpProvider = MockHttpProvider();
  MockContactService mockContactService = MockContactService();

  Contact contact = Contact(
        shareLocationTo: true,
        id: "id",
        name: "name",
        email: "email",
        imageUrl: "url",
        phone: "phone");

  when(mockContactService.getAll()).thenAnswer((_) => Future.value([contact]));

  setUpAll(() {

    GetIt.I.registerSingleton<UserState>(mockUserState);
    GetIt.I.registerSingleton<HttpProvider>(mockHttpProvider);
  });

  test('contactRefsToContactLocations merge the data correctly', () async {
    FiredartListenerServiceImpl firedartListenerServiceImpl =
        FiredartListenerServiceImpl();

    ContactRefModel contactRefModel = ContactRefModel(
      address: 'address',
      lastUpdated: Timestamp.now(),
      location: const GeoPoint(10.2, 20.3),
      uid: 'id'
    );

    final located = await firedartListenerServiceImpl.contactRefsToContactLocations([contactRefModel], contactService: mockContactService);

    expect(located.first.address, contactRefModel.address);
    expect(located.first.name, contact.name);
  });
  
}
