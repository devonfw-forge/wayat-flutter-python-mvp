import 'dart:typed_data';

class ContactAdressBook {
  String name;
  String phoneNumber;
  Uint8List? photo;

  ContactAdressBook({
    required this.name,
    required this.phoneNumber,
    this.photo,
  });
}
