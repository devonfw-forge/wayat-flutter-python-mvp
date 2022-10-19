import 'package:flutter_test/flutter_test.dart';
import 'package:wayat/navigation/home_nav_state/home_nav_state.dart';
import 'package:wayat/domain/contact/contact.dart';

void main() async {
  test("Initial Home State is correct", () {
    HomeNavState homeState = HomeNavState();
    expect(homeState.selectedContact, null);
  });
  test("Set selected contacts test", () {
    HomeNavState homeState = HomeNavState();
    Contact oldContact = _contactFactory("Old Contact");
    Contact newContact = _contactFactory("New contact");
    homeState.selectedContact = oldContact;

    expect(homeState.selectedContact, oldContact);

    homeState.setSelectedContact(newContact);

    expect(homeState.selectedContact, newContact);
  });
}

Contact _contactFactory(String contactName) {
  return Contact(
    shareLocationTo: true,
    id: "id $contactName",
    name: contactName,
    email: "Contact email",
    imageUrl: "https://example.com/image",
    phone: "123",
  );
}
