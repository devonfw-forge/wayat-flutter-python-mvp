import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';
import 'package:wayat/features/contacts/controller/requests_controller/requests_controller.dart';
import 'package:wayat/features/contacts/controller/suggestions_controller/suggestions_controller.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:wayat/navigation/app_router.gr.dart';
import 'package:wayat/services/contact/contact_service.dart';
import 'suggestions_controller_test.mocks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget createApp() {
  return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    onGenerateTitle: (context) {
      GetIt.I.get<LangSingleton>().initialize(context);
      return GetIt.I.get<LangSingleton>().appLocalizations.appTitle;
    },
  );
}

@GenerateMocks([ContactService, FriendsController, RequestsController])
void main() async {
  GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
  MockContactService mockContactService = MockContactService();
  MockFriendsController mockFriendsController = MockFriendsController();
  MockRequestsController mockRequestsController = MockRequestsController();

  SuggestionsController controller = SuggestionsController(
      friendsController: mockFriendsController,
      contactsService: mockContactService,
      requestsController: mockRequestsController);

  List<Contact> contacts = <Contact>[
    Contact(
        shareLocation: false,
        available: true,
        id: "1",
        name: "Test 1",
        email: "test1@mail.com",
        imageUrl: "image1",
        phone: "123456781"),
    Contact(
        shareLocation: false,
        available: false,
        id: "2",
        name: "Test 2",
        email: "test2@mail.com",
        imageUrl: "image2",
        phone: "123456782"),
    Contact(
        shareLocation: false,
        available: true,
        id: "3",
        name: "Test 3",
        email: "test3@mail.com",
        imageUrl: "image3",
        phone: "123456783"),
    Contact(
        shareLocation: false,
        available: true,
        id: "4",
        name: "Test 4",
        email: "test4@mail.com",
        imageUrl: "image4",
        phone: "123456784"),
    Contact(
        shareLocation: false,
        available: false,
        id: "5",
        name: "Test 5",
        email: "test5@mail.com",
        imageUrl: "image5",
        phone: "123456785"),
  ];

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
  });

  // test('Update suggested contacts', () async {
  //   expect(controller.allSuggestions, []);
  //   await controller.updateSuggestedContacts();
  //   // expect(controller.allSuggestions.length, 5);
  // });

  // setUp(() async {
  //   debugDefaultTargetPlatformOverride = TargetPlatform.android;
  // });

  testWidgets('Text invitation', (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    await tester.pumpWidget(createApp());
    expect(controller.platformText(), appLocalizations.invitationTextAndroid);
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    expect(controller.platformText(), appLocalizations.invitationTextIOS);
    debugDefaultTargetPlatformOverride = null;
  });
}
