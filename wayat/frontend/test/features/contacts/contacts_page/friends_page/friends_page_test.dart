import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';
import 'package:wayat/features/contacts/pages/contacts_page/friends_page/friends_page.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mobx/mobx.dart' as mobx;

import 'friends_page_test.mocks.dart';

@GenerateMocks([ContactsPageController, FriendsController])
void main() async {
  final FriendsController mockFriendsController = MockFriendsController();
  final ContactsPageController mockContactsPageController =
      MockContactsPageController();

  setUpAll(() {
    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
    GetIt.I
        .registerSingleton<ContactsPageController>(mockContactsPageController);
    when(mockContactsPageController.friendsController)
        .thenReturn(mockFriendsController);
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

  testWidgets("Friends page title is correct", (tester) async {
    when(mockFriendsController.filteredContacts)
        .thenReturn(mobx.ObservableList.of([]));

    await tester.pumpWidget(_createApp(FriendsPage()));
    await tester.pumpAndSettle();

    expect(
        find.text("${appLocalizations.friendsPageTitle} (0)"), findsOneWidget);

    when(mockFriendsController.filteredContacts)
        .thenReturn(mobx.ObservableList.of([]));
  });
}
