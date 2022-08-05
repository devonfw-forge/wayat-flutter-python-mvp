import 'package:wayat/domain/location/contact_location.dart';

class ContactLocationMock {
  static final List<ContactLocation> contacts = [
    ContactLocation(
        available: true,
        displayName: "User active",
        username: "active",
        email: "user@mail.com",
        imageUrl:
            "https://gravatar.com/avatar/2f95d2d2103f7ad5245cc3b24f223943?s=400&d=mp&r=x",
        latitude: 39.46799126816723,
        longitude: -0.3559132477211037,
        lastUpdated: DateTime.now().subtract(const Duration(minutes: 6))),
    ContactLocation(
        available: true,
        displayName: "User pepe",
        username: "pepe",
        email: "user@mail.com",
        imageUrl:
            "https://gravatar.com/avatar/2f95d2d2103f7ad5245cc3b24f223943?s=400&d=mp&r=x",
        latitude: 39.487762537239135,
        longitude: -0.46046622208940335,
        lastUpdated: DateTime.now().subtract(const Duration(minutes: 6))),
    ContactLocation(
        available: false,
        displayName: "Pepe USer",
        username: "pepeuser",
        email: "user@mail.com",
        imageUrl:
            "https://gravatar.com/avatar/2f95d2d2103f7ad5245cc3b24f223943?s=400&d=mp&r=x",
        latitude: 39.444825299007185,
        longitude: -0.37600882598488544,
        lastUpdated: DateTime.now().subtract(const Duration(minutes: 6))),
    ContactLocation(
        available: true,
        displayName: "Name",
        username: "name",
        email: "user@mail.com",
        imageUrl:
            "https://gravatar.com/avatar/2f95d2d2103f7ad5245cc3b24f223943?s=400&d=mp&r=x",
        latitude: 39.456887507422074,
        longitude: -0.2858866045318938,
        lastUpdated: DateTime.now().subtract(const Duration(minutes: 6))),
    ContactLocation(
        available: false,
        displayName: "DisplayName User",
        username: "display",
        email: "user@mail.com",
        imageUrl:
            "https://gravatar.com/avatar/2f95d2d2103f7ad5245cc3b24f223943?s=400&d=mp&r=x",
        latitude: 39.52352332959457,
        longitude: -0.4156626035399936,
        lastUpdated: DateTime.now().subtract(const Duration(minutes: 6))),
    ContactLocation(
        available: true,
        displayName: "Test test",
        username: "test",
        email: "user@mail.com",
        imageUrl:
            "https://gravatar.com/avatar/2f95d2d2103f7ad5245cc3b24f223943?s=400&d=mp&r=x",
        latitude: 39.49862516861606,
        longitude: -0.4026163391010844,
        lastUpdated: DateTime.now().subtract(const Duration(minutes: 6))),
    ContactLocation(
        available: false,
        displayName: "Test testing",
        username: "testing",
        email: "user@mail.com",
        imageUrl:
            "https://gravatar.com/avatar/2f95d2d2103f7ad5245cc3b24f223943?s=400&d=mp&r=x",
        latitude: 39.460333469009,
        longitude: -0.4506815238456867,
        lastUpdated: DateTime.now().subtract(const Duration(minutes: 6))),
    ContactLocation(
        available: true,
        displayName: "Testing testing",
        username: "testingtesting",
        email: "user@mail.com",
        imageUrl:
            "https://gravatar.com/avatar/2f95d2d2103f7ad5245cc3b24f223943?s=400&d=mp&r=x",
        latitude: 37.5702,
        longitude: -0.786805,
        lastUpdated: DateTime.now().subtract(const Duration(minutes: 6))),
    ContactLocation(
        available: false,
        displayName: "Testing test",
        username: "testingtest",
        email: "user@mail.com",
        imageUrl:
            "https://gravatar.com/avatar/2f95d2d2103f7ad5245cc3b24f223943?s=400&d=mp&r=x",
        latitude: 39.1702,
        longitude: -0.686805,
        lastUpdated: DateTime.now().subtract(const Duration(minutes: 6))),
    ContactLocation(
        available: true,
        displayName: "User the second",
        username: "USERsecond",
        email: "user@mail.com",
        imageUrl:
            "https://gravatar.com/avatar/2f95d2d2103f7ad5245cc3b24f223943?s=400&d=mp&r=x",
        latitude: 42.9702,
        longitude: -0.386805,
        lastUpdated: DateTime.now().subtract(const Duration(minutes: 6))),
    ContactLocation(
        available: true,
        displayName: "User the third",
        username: "third",
        email: "user@mail.com",
        imageUrl:
            "https://gravatar.com/avatar/2f95d2d2103f7ad5245cc3b24f223943?s=400&d=mp&r=x",
        latitude: 43.9702,
        longitude: -0.486805,
        lastUpdated: DateTime.now().subtract(const Duration(minutes: 6))),
    ContactLocation(
        available: false,
        displayName: "User the fourth",
        username: "fourth",
        email: "user@mail.com",
        imageUrl:
            "https://gravatar.com/avatar/2f95d2d2103f7ad5245cc3b24f223943?s=400&d=mp&r=x",
        latitude: 39.9702,
        longitude: -0.386805,
        lastUpdated: DateTime.now().subtract(const Duration(minutes: 6))),
    ContactLocation(
        available: true,
        displayName: "User the fifth",
        username: "fifth",
        email: "user@mail.com",
        imageUrl:
            "https://gravatar.com/avatar/2f95d2d2103f7ad5245cc3b24f223943?s=400&d=mp&r=x",
        latitude: 36.2702,
        longitude: -0.686805,
        lastUpdated: DateTime.now().subtract(const Duration(minutes: 6))),
    ContactLocation(
        available: false,
        displayName: "User the barbarian",
        username: "barbarian",
        email: "user@mail.com",
        imageUrl:
            "https://gravatar.com/avatar/2f95d2d2103f7ad5245cc3b24f223943?s=400&d=mp&r=x",
        latitude: 44.9702,
        longitude: -0.586805,
        lastUpdated: DateTime.now().subtract(const Duration(minutes: 6))),
    ContactLocation(
        available: true,
        displayName: "User the wise",
        username: "wise",
        email: "user@mail.com",
        imageUrl:
            "https://gravatar.com/avatar/2f95d2d2103f7ad5245cc3b24f223943?s=400&d=mp&r=x",
        latitude: 42.3702,
        longitude: -0.786805,
        lastUpdated: DateTime.now().subtract(const Duration(minutes: 6))),
  ];
}
