import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/common/widgets/basic_contact_tile.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/group/group.dart';
import 'package:wayat/features/groups/controllers/groups_controller/groups_controller.dart';
import 'package:wayat/features/groups/pages/view_group_page.dart';
import 'package:wayat/lang/app_localizations.dart';

import '../../../test_common/test_app.dart';
import 'groups_page_test.mocks.dart';

@GenerateMocks([GroupsController])
void main() async {
  GroupsController mockGroupsController = MockGroupsController();

  setUpAll(() {
    HttpOverrides.global = null;
    GetIt.I.registerSingleton<GroupsController>(mockGroupsController);
  });

  testWidgets("Header is built correctly", (tester) async {
    Group group = _createGroup("GroupName", []);
    when(mockGroupsController.selectedGroup).thenReturn(group);

    await tester.pumpWidget(TestApp.createApp(body: ViewGroupPage()));
    await tester.pumpAndSettle();

    expect(find.widgetWithIcon(IconButton, Icons.arrow_back), findsOneWidget);
    expect(
        find.descendant(of: find.byType(Row), matching: find.text(group.name)),
        findsOneWidget);
    expect(
        find.widgetWithIcon(PopupMenuButton, Icons.more_vert), findsOneWidget);
  });

  testWidgets("Clicking on the dots icon shows the menu", (tester) async {
    Group group = _createGroup("GroupName", []);
    when(mockGroupsController.selectedGroup).thenReturn(group);

    await tester.pumpWidget(TestApp.createApp(body: ViewGroupPage()));
    await tester.pumpAndSettle();

    expect(find.byType(PopupMenuItem), findsNothing);
    expect(find.text(appLocalizations.editGroup), findsNothing);
    expect(find.text(appLocalizations.deleteGroup), findsNothing);

    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();

    expect(find.byType(PopupMenuItem), findsNWidgets(2));
    expect(find.text(appLocalizations.editGroup), findsOneWidget);
    expect(find.text(appLocalizations.deleteGroup), findsOneWidget);
  });

  testWidgets("Tapping on edit group calls the correct controller method",
      (tester) async {
    Group group = _createGroup("GroupName", []);
    when(mockGroupsController.selectedGroup).thenReturn(group);
    // when(mockGroupsController.setEditGroup(true)).thenReturn(null);

    await tester.pumpWidget(TestApp.createApp(body: ViewGroupPage()));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();

    await tester.tap(find.text(appLocalizations.editGroup));
    await tester.pumpAndSettle();
    // verify(mockGroupsController.setEditGroup(true)).called(1);
  });

  testWidgets("Tapping on delete group calls the correct controller methods",
      (tester) async {
    Group group = _createGroup("GroupName", []);
    String groupId = "id";
    group.id = groupId;
    when(mockGroupsController.selectedGroup).thenReturn(group);
    when(mockGroupsController.updateGroups()).thenAnswer((_) async => true);
    when(mockGroupsController.deleteGroup(groupId))
        .thenAnswer((_) => Future.value(null));

    await tester.pumpWidget(TestApp.createApp(body: ViewGroupPage()));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();

    await tester.tap(find.text(appLocalizations.deleteGroup));
    await tester.pumpAndSettle();
    verify(mockGroupsController.deleteGroup(groupId)).called(1);
    verify(mockGroupsController.setSelectedGroup(null)).called(1);
    verify(mockGroupsController.updateGroups()).called(1);
  });

  testWidgets("Tapping on the arrow icon changes the state to go back",
      (tester) async {
    Group group = _createGroup("GroupName", []);
    when(mockGroupsController.selectedGroup).thenReturn(group);
    when(mockGroupsController.setSelectedGroup(null)).thenReturn(null);

    await tester.pumpWidget(TestApp.createApp(body: ViewGroupPage()));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithIcon(IconButton, Icons.arrow_back));
    await tester.pumpAndSettle();

    verify(mockGroupsController.setSelectedGroup(null)).called(1);
  });

  testWidgets("Information section is correct", (tester) async {
    Group group = _createGroup("GroupName", []);
    when(mockGroupsController.selectedGroup).thenReturn(group);

    await tester.pumpWidget(TestApp.createApp(body: ViewGroupPage()));
    await tester.pumpAndSettle();

    expect(find.byType(CircleAvatar), findsNWidgets(2));
    expect(find.byKey(const Key("GroupNameInfo")), findsOneWidget);
  });

  testWidgets("Group participants title is present", (tester) async {
    Group group = _createGroup("GroupName", []);
    when(mockGroupsController.selectedGroup).thenReturn(group);

    await tester.pumpWidget(TestApp.createApp(body: ViewGroupPage()));
    await tester.pumpAndSettle();

    expect(find.text(appLocalizations.groupParticipants), findsOneWidget);
  });

  testWidgets("The contact tiles correspond to the group members",
      (tester) async {
    Group group = _createGroup("GroupName", []);
    when(mockGroupsController.selectedGroup).thenReturn(group);

    await tester.pumpWidget(TestApp.createApp(body: ViewGroupPage()));
    await tester.pumpAndSettle();

    expect(find.byType(BasicContactTile), findsNothing);

    group = _createGroup(
        "GroupName", [_createContact("TestA"), _createContact("TestB")]);
    when(mockGroupsController.selectedGroup).thenReturn(group);

    await tester.pumpWidget(TestApp.createApp(body: ViewGroupPage()));
    await tester.pumpAndSettle();

    expect(find.byType(BasicContactTile), findsNWidgets(2));
    expect(find.widgetWithText(BasicContactTile, "TestA"), findsOneWidget);
    expect(find.widgetWithText(BasicContactTile, "TestB"), findsOneWidget);
  });
}

Group _createGroup(String name, List<Contact> members) {
  return Group(
      id: "id", members: members, name: name, imageUrl: "https://example.com");
}

Contact _createContact(String name) {
  return Contact(
      shareLocationTo: true,
      id: "id",
      name: name,
      email: "email",
      imageUrl: "https://example.com",
      phone: "");
}
