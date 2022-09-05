import 'package:flutter_test/flutter_test.dart';
import 'package:wayat/app_state/home_state/home_state.dart';
import 'package:wayat/domain/contact/contact.dart';

void main() async {
  test("Initial Home State is correct", () {
    HomeState homeState = HomeState();
    expect(homeState.selectedContact, null);
    expect(homeState.navigationSourceContactProfile, "");
  });
  test("Set selected contacts test", () {
    HomeState homeState = HomeState();
    Contact oldContact = _contactFactory("Old Contact");
    Contact newContact = _contactFactory("New contact");
    String oldSource = "old source";
    String newSource = "new source";
    homeState.selectedContact = oldContact;
    homeState.navigationSourceContactProfile = oldSource;

    expect(homeState.selectedContact, oldContact);
    expect(homeState.navigationSourceContactProfile, oldSource);

    homeState.setSelectedContact(newContact, newSource);

    expect(homeState.selectedContact, newContact);
    expect(homeState.navigationSourceContactProfile, newSource);
  });
}

Contact _contactFactory(String contactName) {
  return Contact(
    available: true,
    id: "id $contactName",
    name: contactName,
    email: "Contact email",
    imageUrl: "https://example.com/image",
    phone: "123",
  );
}
