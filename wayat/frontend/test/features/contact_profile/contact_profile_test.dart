import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/home_state/home_state.dart';
import 'package:wayat/app_state/user_status/user_status_state.dart';
import 'package:wayat/common/widgets/buttons/circle_icon_button.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/features/contact_profile/controller/contact_profile_controller.dart';
import 'package:wayat/features/contact_profile/page/contact_profile_page.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'contact_profile_test.mocks.dart';

@GenerateMocks([UserStatusState, ContactProfileController, HomeState])
void main() async {
  // Constants for the test contacts creation
  const String contactName = "Contact Name";
  const String contactAddress = "Address Street 21";
  DateTime lastUpdated = DateTime(2000, 12, 21);

  late UserStatusState mockUserStatusState;
  late HomeState mockHomeState;
  late ContactProfileController mockController;

  late Contact nonLocatedContact;
  late ContactLocation locatedContact;

  ContactLocation locatedContactFactory() {
    return ContactLocation(
        available: true,
        id: "id1",
        name: contactName,
        email: "Contact email",
        imageUrl: "https://example.com/image",
        phone: "123",
        latitude: 1,
        longitude: 1,
        address: contactAddress,
        lastUpdated: lastUpdated);
  }

  Contact nonLocatedContactFactory() {
    return Contact(
        available: false,
        id: "id2",
        name: contactName,
        email: "Contact email",
        imageUrl: "https://example.com/image",
        phone: "123");
  }

  setUpAll(() {
    mockUserStatusState = MockUserStatusState();
    mockHomeState = MockHomeState();

    GetIt.I.registerSingleton<UserStatusState>(mockUserStatusState);
    GetIt.I.registerSingleton<HomeState>(mockHomeState);
    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());

    nonLocatedContact = nonLocatedContactFactory();
    locatedContact = locatedContactFactory();
    mockController = MockContactProfileController();

    HttpOverrides.global = null;

    when(mockUserStatusState.contacts).thenReturn([locatedContact]);
  });

  Widget _createApp(Widget body) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) {
        GetIt.I.get<LangSingleton>().initialize(context);
        return GetIt.I.get<LangSingleton>().appLocalizations.appTitle;
      },
      home: Scaffold(
        body: body,
      ),
    );
  }

  group("Contact Profile has a correct app bar", () {
    testWidgets("There is a back arrow button", (tester) async {
      await tester.pumpWidget(_createApp(ContactProfilePage(
          contact: nonLocatedContact, navigationSource: "Contacts")));
      expect(find.widgetWithIcon(IconButton, Icons.arrow_back), findsOneWidget);
    });

    testWidgets("The navigation source matches with the appbar title",
        (tester) async {
      await tester.pumpWidget(_createApp(ContactProfilePage(
          contact: nonLocatedContact,
          navigationSource: "Navigation Source 1")));
      expect(find.text("Navigation Source 1"), findsOneWidget);

      await tester.pumpWidget(_createApp(ContactProfilePage(
          contact: nonLocatedContact,
          navigationSource: "Navigation Source 2")));
      expect(find.text("Navigation Source 2"), findsOneWidget);
    });

    testWidgets("Exits the page correctly", (tester) async {
      await tester.pumpWidget(_createApp(ContactProfilePage(
          contact: nonLocatedContact, navigationSource: "Contacts")));
      await tester.tap(find.widgetWithIcon(IconButton, Icons.arrow_back));
      verify(mockHomeState.setSelectedContact(null, "")).called(1);
    });
  });

  group("The map section is displayed correctly", () {
    testWidgets("The map does not appear when the contact cannot be located",
        (tester) async {
      await tester.pumpWidget(_createApp(ContactProfilePage(
          contact: nonLocatedContact, navigationSource: "Contacts")));
      await tester.pump();

      expect(find.byType(GoogleMap), findsNothing);
    });

    testWidgets("There is a message indicating that location is not available",
        (tester) async {
      await tester.pumpWidget(_createApp(ContactProfilePage(
          contact: nonLocatedContact, navigationSource: "Contacts")));
      await tester.pump();

      expect(find.text(appLocalizations.contactProfileLocationNotAvailable),
          findsOneWidget);
    });

    testWidgets("The map appears when the contact can be located",
        (tester) async {
      when(mockController.getMarkerImage(locatedContact)).thenAnswer(
          (realInvocation) => Future.value(BitmapDescriptor.defaultMarker));

      await tester.pumpWidget(_createApp(ContactProfilePage(
          contact: locatedContact,
          navigationSource: "Contacts",
          controller: mockController)));
      await tester.pump();

      expect(find.byType(GoogleMap), findsOneWidget);
    });

    testWidgets("There is no message when the map is loaded", (tester) async {
      when(mockController.getMarkerImage(locatedContact)).thenAnswer(
          (realInvocation) => Future.value(BitmapDescriptor.defaultMarker));

      await tester.pumpWidget(_createApp(ContactProfilePage(
          contact: locatedContact,
          navigationSource: "Contacts",
          controller: mockController)));
      await tester.pump();

      expect(find.text(appLocalizations.contactProfileLocationNotAvailable),
          findsNothing);
    });
  });

  group("The contact info section displays correctly", () {
    testWidgets("The contact name displays correctly with non located contact",
        (tester) async {
      await tester.pumpWidget(_createApp(ContactProfilePage(
          contact: nonLocatedContact, navigationSource: "Contacts")));
      expect(find.text(nonLocatedContact.name), findsOneWidget);
    });

    testWidgets("The contact name displays correctly with located contact",
        (tester) async {
      await tester.pumpWidget(_createApp(ContactProfilePage(
          contact: nonLocatedContact, navigationSource: "Contacts")));
      expect(find.text(locatedContact.name), findsOneWidget);
    });

    testWidgets("Address appears with located contact", (tester) async {
      await tester.pumpWidget(_createApp(ContactProfilePage(
          contact: locatedContact, navigationSource: "Contacts")));
      expect(find.text(locatedContact.address), findsOneWidget);
    });

    testWidgets("Last update appears correctly with located contact",
        (tester) async {
      await tester.pumpWidget(_createApp(ContactProfilePage(
          contact: locatedContact, navigationSource: "Contacts")));
      expect(
          find.text(
              "${appLocalizations.contactProfileLastUpdated} ${timeago.format(locatedContact.lastUpdated)}"),
          findsOneWidget);
    });

    testWidgets(
        "Sharing location with you message appears when contact is located",
        (tester) async {
      await tester.pumpWidget(_createApp(ContactProfilePage(
          contact: locatedContact, navigationSource: "Contacts")));
      expect(find.text(appLocalizations.contactProfileSharingLocationWithYou),
          findsOneWidget);
    });

    testWidgets(
        "Sharing location with you message does not appear when contact is not located",
        (tester) async {
      await tester.pumpWidget(_createApp(ContactProfilePage(
          contact: nonLocatedContact, navigationSource: "Contacts")));
      expect(find.text(appLocalizations.contactProfileSharingLocationWithYou),
          findsNothing);
    });

    testWidgets("Profile picture with border appears with located contact",
        (tester) async {
      await tester.pumpWidget(_createApp(ContactProfilePage(
          contact: locatedContact, navigationSource: "Contacts")));
      expect(find.byType(CircleAvatar), findsWidgets);
    });
    testWidgets("Profile picture with border appears with non located contact",
        (tester) async {
      await tester.pumpWidget(_createApp(ContactProfilePage(
          contact: nonLocatedContact, navigationSource: "Contacts")));
      await tester.pump();
      expect(find.byType(CircleAvatar), findsWidgets);
    });

    testWidgets("Routing button appears with located contact", (tester) async {
      await tester.pumpWidget(_createApp(ContactProfilePage(
          contact: locatedContact, navigationSource: "Contacts")));
      expect(find.widgetWithIcon(CircleIconButton, Icons.directions_outlined),
          findsOneWidget);
    });
    testWidgets("Routing button does not appear with non located contact",
        (tester) async {
      await tester.pumpWidget(_createApp(ContactProfilePage(
          contact: nonLocatedContact, navigationSource: "Contacts")));
      expect(find.widgetWithIcon(CircleIconButton, Icons.directions_outlined),
          findsNothing);
    });

    testWidgets(
        "Google Maps service is called when pressing the Routing button",
        (tester) async {
      when(mockController.openMaps(locatedContact)).thenReturn(null);
      when(mockController.getMarkerImage(locatedContact)).thenAnswer(
          (realInvocation) => Future.value(BitmapDescriptor.defaultMarker));

      await tester.pumpWidget(_createApp(ContactProfilePage(
        contact: locatedContact,
        navigationSource: "Contacts",
        controller: mockController,
      )));
      await tester.pump();
      await tester.tap(find.byType(CircleIconButton));
      verify(mockController.openMaps(locatedContact)).called(1);
    });
  });
}
