import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/common/widgets/buttons/custom_text_button.dart';
import 'package:wayat/common/widgets/message_card.dart';
import 'package:wayat/domain/group/group.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/groups/controllers/groups_controller/groups_controller.dart';
import 'package:wayat/features/groups/pages/groups_page.dart';
import 'package:wayat/features/groups/widgets/group_tile.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:wayat/services/groups/groups_service.dart';
import 'package:mobx/mobx.dart' as mobx;

import 'groups_page_test.mocks.dart';

@GenerateMocks([GroupsController, GroupsService, ContactsPageController])
void main() async {
  GroupsController mockGroupsController = MockGroupsController();
  ContactsPageController mockContactsPageController =
      MockContactsPageController();

  setUpAll(() {
    HttpOverrides.global = null;
    GetIt.I.registerSingleton(LangSingleton());
    GetIt.I.registerSingleton<GroupsController>(mockGroupsController);
    GetIt.I
        .registerSingleton<ContactsPageController>(mockContactsPageController);

    when(mockGroupsController.updateGroups())
        .thenAnswer((_) => Future.value(true));
  });

  Widget createApp(Widget body) {
    final router = GoRouter(initialLocation: "/", routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => Scaffold(
          body: body,
        ),
      ),
    ]);
    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) {
        GetIt.I.get<LangSingleton>().initialize(context);
        return GetIt.I.get<LangSingleton>().appLocalizations.appTitle;
      },
      routerConfig: router,
    );
  }

  testWidgets("Groups header appears correctly", (tester) async {
    when(mockGroupsController.groups).thenReturn(mobx.ObservableList.of([]));
    await tester.pumpWidget(createApp(GroupsPage()));
    await tester.pumpAndSettle();

    expect(find.widgetWithIcon(IconButton, Icons.keyboard_arrow_down),
        findsOneWidget);
    expect(find.widgetWithText(CustomTextButton, appLocalizations.createGroup),
        findsOneWidget);
    expect(find.text(appLocalizations.groupsTitle), findsOneWidget);
  });

  testWidgets("Tapping on create group moves to manage group screen",
      (tester) async {
    when(mockGroupsController.groups).thenReturn(mobx.ObservableList.of([]));
    when(mockGroupsController.setSelectedGroup(Group.empty())).thenReturn(null);
    await tester.pumpWidget(createApp(GroupsPage()));
    await tester.pumpAndSettle();

    await tester.tap(
        find.widgetWithText(CustomTextButton, appLocalizations.createGroup));
    await tester.pumpAndSettle();

    verify(mockGroupsController.setSelectedGroup(Group.empty())).called(1);
  });

  testWidgets("The no groups message appears correctly", (tester) async {
    when(mockGroupsController.groups).thenReturn(mobx.ObservableList.of([]));
    await tester.pumpWidget(createApp(GroupsPage()));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(MessageCard, appLocalizations.noGroupsMessage),
        findsOneWidget);

    when(mockGroupsController.groups).thenReturn(mobx.ObservableList.of([
      Group(id: "", name: "", imageUrl: "https://example.com", members: [])
    ]));
    await tester.pumpWidget(createApp(GroupsPage()));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(MessageCard, appLocalizations.noGroupsMessage),
        findsNothing);
  });

  testWidgets("The groups tiles appear correctly", (tester) async {
    when(mockGroupsController.groups).thenReturn(mobx.ObservableList.of([
      Group(
          id: "name",
          name: "name",
          imageUrl: "https://example.com",
          members: [])
    ]));
    await tester.pumpWidget(createApp(GroupsPage()));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(GroupTile, "name"), findsOneWidget);
  });

  testWidgets("Tapping group tile calls the correct method on the controller",
      (tester) async {
    Group group = Group(
        id: "name", name: "name", imageUrl: "https://example.com", members: []);
    when(mockGroupsController.groups)
        .thenReturn(mobx.ObservableList.of([group]));
    when(mockGroupsController.setSelectedGroup(group)).thenReturn(null);
    await tester.pumpWidget(createApp(GroupsPage()));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(GroupTile, "name"));
    await tester.pumpAndSettle();

    verify(mockGroupsController.setSelectedGroup(group)).called(1);
  });
}
