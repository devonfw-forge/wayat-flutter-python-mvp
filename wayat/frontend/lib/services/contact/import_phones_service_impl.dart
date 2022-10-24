import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/services/contact/flutter_contacts_handler_libw.dart';

/// Service to read the contacts stored in the device and import them to the app.
class ContactsAddressServiceImpl {
  /// Reads all contacts stored in the device and returns only their phone numbers.
  ///
  /// First, it needs to check and/or ask for permission to read the contacts and,
  /// if allowed, obtains them and returns just the phones.
  ///
  /// The optional parameter of type [FlutterContactsHandlerLibW] is present for testing purposes.
  Future<List<String>> getAllPhones(
      {FlutterContactsHandlerLibW? handler}) async {
    FlutterContactsHandlerLibW contactsHandler =
        handler ?? FlutterContactsHandlerLibW();
    if (await contactsHandler.requestPermission()) {
      List<Contact> contacts = await contactsHandler.getContacts();
      MyUser user = GetIt.I.get<UserState>().currentUser!;
      return contacts
          .expand((contact) => contact.phones.map((e) {
                String phoneNumber =
                    e.number.replaceAll(RegExp(r'[^+0-9]+'), '');
                if (phoneNumber.length ==
                        (user.phone.length - user.phonePrefix.length) &&
                    !phoneNumber.startsWith("+")) {
                  return user.phonePrefix + phoneNumber;
                }
                return phoneNumber;
              }))
          // Delete repeated contacts
          .toSet()
          .toList();
    }
    return [];
  }
}
