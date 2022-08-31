import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/common/widgets/search_bar.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/pages/contacts_page/contacts_page.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wayat/navigation/app_router.gr.dart';

import 'contacts_page_test.mocks.dart';

@GenerateMocks([ContactsPageController, SessionState])
void main() async {
  HttpOverrides.global = null;

  final ContactsPageController mockContactsPageController =
      MockContactsPageController();
  final SessionState mockSessionState = MockSessionState();

  when(mockContactsPageController.searchBarController)
      .thenReturn(TextEditingController());

  setUpAll(() {
    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
    GetIt.I
        .registerSingleton<ContactsPageController>(mockContactsPageController);
    GetIt.I.registerSingleton<SessionState>(mockSessionState);
  });

  Widget _createApp(Widget body) {
    final appRouter = AppRouter();

    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) {
        GetIt.I.get<LangSingleton>().initialize(context);
        return GetIt.I.get<LangSingleton>().appLocalizations.appTitle;
      },
      routerDelegate:
          appRouter.delegate(initialRoutes: [RootWrapper(), HomeWrapper()]),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }

  //testWidgets("The searchbar appears correctly", (tester) async {
  //await tester.pumpWidget(_createApp(ContactsPage()));
  //expect(find.byType(SearchBar), findsOneWidget);
  //});
}
