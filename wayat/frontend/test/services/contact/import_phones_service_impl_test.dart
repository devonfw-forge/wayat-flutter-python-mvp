import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/services/contact/flutter_contacts_handler_libw.dart';
import 'package:wayat/services/contact/import_phones_service_impl.dart';
import 'package:wayat/services/utils/list_utils_service.dart';

import 'import_phones_service_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FlutterContactsHandlerLibW>(),
  MockSpec<UserState>(),
])
void main() async {
  MyUser user = MyUser(
    id: "1",
    phone: "+34123456789",
    phonePrefix: "+34",
    name: "fakeName",
    email: "fakeEmail@mail.com",
    imageUrl: "https://fakeurl",
    onboardingCompleted: true,
    shareLocationEnabled: true,
  );
  MockUserState mockUserState = MockUserState();
  when(mockUserState.currentUser).thenReturn(user);
  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    GetIt.I.registerSingleton<UserState>(mockUserState);
  });
  test(
      "GetAllPhones returns empty list if the permission of contacts is denied",
      () async {
    FlutterContactsHandlerLibW mockHandler = MockFlutterContactsHandlerLibW();
    when(mockHandler.requestPermission()).thenAnswer((_) async => false);
    expect([],
        await ContactsAddressServiceImpl().getAllPhones(handler: mockHandler));
  });

  test(
      "GetAllPhones returns phones of contacts excluding duplicates and user phone",
      () async {
    List<Contact> contacts = [
      Contact(
          name: Name(first: "Test", last: "Test"),
          phones: [Phone("(+34) 987654321"), Phone("+34-987654321")]),
      Contact(
          name: Name(first: "Test2", last: "Test"),
          phones: [Phone("1234"), Phone("4321"), Phone("1234")]),
      Contact(
          name: Name(first: "Test3", last: "Test"),
          phones: [Phone("111222333")]),
      Contact(
          name: Name(first: "User", last: "User"),
          phones: [Phone("123456789"), Phone("+34123456789")])
    ];

    MockFlutterContactsHandlerLibW mockHandler =
        MockFlutterContactsHandlerLibW();
    when(mockHandler.requestPermission()).thenAnswer((_) async => true);
    when(mockHandler.getContacts()).thenAnswer((_) async => contacts);

    List<String> res = ["+34987654321", "1234", "4321", "+34111222333"];

    expect(
      ListUtilsService.haveDifferentElements(
          res,
          await ContactsAddressServiceImpl()
              .getAllPhones(handler: mockHandler)),
      false,
    );
  });
}
