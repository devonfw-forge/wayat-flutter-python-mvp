import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/common/widgets/buttons/custom_text_button.dart';
import 'package:wayat/common/widgets/message_card.dart';
import 'package:wayat/domain/group/group.dart';
import 'package:wayat/features/groups/controllers/groups_controller/groups_controller.dart';
import 'package:wayat/features/groups/pages/groups_page.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:wayat/services/groups/groups_service.dart';

import 'groups_page_test.mocks.dart';

@GenerateMocks([GroupsController, GroupsService])
void main() async {
  GroupsController mockGroupsController = MockGroupsController();

  setUpAll(() {
    HttpOverrides.global = null;
    GetIt.I.registerSingleton(LangSingleton());
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

  testWidgets("Groups header appears correctly", (tester) async {
    when(mockGroupsController.groups).thenReturn([]);
    await tester.pumpWidget(
        _createApp(GroupsPage(groupsController: mockGroupsController)));
    await tester.pumpAndSettle();

    expect(find.widgetWithIcon(IconButton, Icons.keyboard_arrow_down),
        findsOneWidget);
    expect(find.widgetWithText(CustomTextButton, appLocalizations.createGroup),
        findsOneWidget);
    expect(find.text(appLocalizations.groupsTitle), findsOneWidget);
  });

  testWidgets("The no groups message appears correctly", (tester) async {
    when(mockGroupsController.groups).thenReturn([]);
    await tester.pumpWidget(
        _createApp(GroupsPage(groupsController: mockGroupsController)));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(MessageCard, appLocalizations.noGroupsMessage),
        findsOneWidget);

    when(mockGroupsController.groups).thenReturn([Group.empty()]);
    await tester.pumpWidget(
        _createApp(GroupsPage(groupsController: mockGroupsController)));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(MessageCard, appLocalizations.noGroupsMessage),
        findsNothing);
  });
}
