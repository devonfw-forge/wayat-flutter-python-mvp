import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/services/contact/flutter_contacts_handler.dart';
import 'package:wayat/services/contact/import_phones_service_impl.dart';
import 'package:wayat/services/utils/list_utils_service.dart';

import 'import_phones_service_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FlutterContactsHandler>()])
void main() async {
  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
  });
  test(
      "GetAllPhones returns empty list if the permission of contacts is denied",
      () async {
    FlutterContactsHandler mockHandler = MockFlutterContactsHandler();
    when(mockHandler.requestPermission()).thenAnswer((_) async => false);
    expect([],
        await ContactsAddressServiceImpl().getAllPhones(handler: mockHandler));
  });

  test("GetAllPhones returns phones of contacts", () async {
    List<Contact> contacts = [
      Contact(
          name: Name(first: "Test", last: "Test"),
          phones: [Phone("123"), Phone("321")]),
      Contact(
          name: Name(first: "Test2", last: "Test"),
          phones: [Phone("1234"), Phone("4321")]),
      Contact(
          name: Name(first: "Test3", last: "Test"), phones: [Phone("12345")])
    ];

    List<String> res = ["123", "321", "1234", "4321", "12345"];

    FlutterContactsHandler mockHandler = MockFlutterContactsHandler();
    when(mockHandler.requestPermission()).thenAnswer((_) async => true);
    when(mockHandler.getContacts()).thenAnswer((_) async => contacts);
    expect(
      ListUtilsService.haveDifferentElements(res,
          await ContactsAddressServiceImpl().getAllPhones(handler: mockHandler)),
      false,
    );
  });
}
