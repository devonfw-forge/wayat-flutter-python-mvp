import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:mockito/mockito.dart';
import 'package:wayat/common/widgets/buttons/invite_wayat.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/suggestions_controller/suggestions_controller.dart';
import 'package:wayat/features/contacts/pages/contacts_page/suggestions_page/suggestions_page.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mockito/annotations.dart';

import 'suggestions_page_test.mocks.dart';

@GenerateMocks([ContactsPageController, SuggestionsController ])
void main() async {
  final SuggestionsController suggestionsController =
      MockSuggestionsController();
  final ContactsPageController mockContactsPageController =
      MockContactsPageController();

  setUpAll(() {
    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
    GetIt.I
        .registerSingleton<ContactsPageController>(mockContactsPageController);
    when(mockContactsPageController.suggestionsController)
        .thenReturn(suggestionsController);
    GetIt.I.registerSingleton<SuggestionsController>(suggestionsController);
    when(suggestionsController.updateSuggestedContacts())
        .thenAnswer((_) => Future.value([]));
    when(suggestionsController.filteredSuggestions)
        .thenReturn(mobx.ObservableList<Contact>.of([]));
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

  testWidgets('Suggestions page has a invitation button', (tester) async {
    await tester.pumpWidget(_createApp(SuggestionsPage()));
    expect(
        find.widgetWithText(CustomInviteWayat, appLocalizations.inviteContacts),
        findsOneWidget);
  });

  testWidgets('Invitation button copies a text', (tester) async {
    when(suggestionsController.copyInvitation()).thenAnswer((_) => Future.value(null));
    await tester.pumpWidget(_createApp(SuggestionsPage()));
    
    await tester.tap(find.byType(TextButton));
    verify(suggestionsController.copyInvitation()).called(1);
  });
}
