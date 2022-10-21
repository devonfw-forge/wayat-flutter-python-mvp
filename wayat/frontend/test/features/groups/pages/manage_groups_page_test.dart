import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/common/widgets/buttons/custom_outlined_button_icon.dart';
import 'package:wayat/common/widgets/buttons/custom_text_button.dart';
import 'package:wayat/common/widgets/custom_textfield.dart';
import 'package:wayat/common/widgets/message_card.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/group/group.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';
import 'package:wayat/features/groups/controllers/groups_controller/groups_controller.dart';
import 'package:wayat/features/groups/controllers/manage_group_controller/manage_group_controller.dart';
import 'package:wayat/features/groups/pages/manage_group_page.dart';
import 'package:wayat/features/groups/widgets/create_group_contact_tile.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:wayat/services/groups/groups_service.dart';

import '../../../test_common/test_app.dart';
import 'manage_groups_page_test.mocks.dart';

@GenerateMocks([
  GroupsController,
  ManageGroupController,
  ContactsPageController,
  FriendsController,
  XFile,
  GroupsService
])
void main() async {
  ManageGroupController mockManageGroupController = MockManageGroupController();
  ContactsPageController mockContactsPageController =
      MockContactsPageController();
  FriendsController mockFriendsController = MockFriendsController();
  GroupsController mockGroupsController = MockGroupsController();

  setUpAll(() {
    HttpOverrides.global = null;
    when(mockContactsPageController.friendsController)
        .thenReturn(mockFriendsController);
    when(mockManageGroupController.groupNameController)
        .thenReturn(TextEditingController());
    when(mockManageGroupController.selectedContacts)
        .thenReturn(mobx.ObservableList.of([]));
    when(mockManageGroupController.selectedFile).thenReturn(null);
    when(mockManageGroupController.selectedFileBytes).thenReturn(null);
    when(mockManageGroupController.showValidationGroup).thenReturn(false);
    GetIt.I
        .registerSingleton<ContactsPageController>(mockContactsPageController);
    GetIt.I.registerSingleton<GroupsController>(mockGroupsController);
  });

  testWidgets("ManageGroups header is correct", (tester) async {
    when(mockManageGroupController.group).thenReturn(Group.empty());
    await tester.pumpWidget(TestApp.createApp(
        body: ManageGroupPage(controller: mockManageGroupController)));
    await tester.pumpAndSettle();

    expect(find.widgetWithIcon(IconButton, Icons.arrow_back), findsOneWidget);
    expect(find.text(appLocalizations.newGroup), findsWidgets);
    expect(find.widgetWithText(CustomTextButton, appLocalizations.save),
        findsOneWidget);
  });

  testWidgets("When pressing back button the current page changes",
      (tester) async {
    when(mockManageGroupController.group).thenReturn(Group.empty());
    when(mockGroupsController.setSelectedGroup(null)).thenReturn(null);

    await tester.pumpWidget(TestApp.createApp(
        body: ManageGroupPage(
      controller: mockManageGroupController,
      key: const Key("ManageGroup"),
    )));
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    verify(mockGroupsController.setSelectedGroup(null)).called(1);
  });

  testWidgets(
      'ValidationGroup with less than two contacts selected set showValidationGroup to true',
      (tester) async {});

  testWidgets(
      'ValidationGroup with two contacts selected set showValidationGroup to false',
      (tester) async {});

  testWidgets("Save button saves group and goes back", (tester) async {
    when(mockManageGroupController.group).thenReturn(Group.empty());
    when(mockGroupsController.setSelectedGroup(null)).thenReturn(null);
    when(mockManageGroupController.saveGroup())
        .thenAnswer((_) => Future.value(null));

    await tester.pumpWidget(TestApp.createApp(
        body: ManageGroupPage(
      controller: mockManageGroupController,
      key: const Key("ManageGroup"),
    )));
    await tester.tap(find.text(appLocalizations.save));
    await tester.pumpAndSettle();

    verify(mockManageGroupController.saveGroup()).called(1);
    verify(mockGroupsController.setSelectedGroup(null)).called(1);
  });

  testWidgets("Group image is built correctly", (tester) async {
    XFile mockPicture = MockXFile();
    when(mockPicture.path).thenReturn("");
    when(mockManageGroupController.group).thenReturn(Group.empty());
    await tester.pumpWidget(TestApp.createApp(
        body: ManageGroupPage(controller: mockManageGroupController)));
    await tester.pumpAndSettle();

    when(mockManageGroupController.selectedFile).thenReturn(null);
    when(mockManageGroupController.selectedFileBytes).thenReturn(null);

    expect(find.byIcon(Icons.person_outline), findsOneWidget);
    expect(
        find.widgetWithIcon(CircleAvatar, Icons.edit_outlined), findsOneWidget);
    expect(
        find.ancestor(
            of: find.widgetWithIcon(CircleAvatar, Icons.person_outline),
            matching: find.byType(Stack)),
        findsNWidgets(2));
    expect(
        find.ancestor(
            of: find.widgetWithIcon(CircleAvatar, Icons.edit_outlined),
            matching: find.byType(Stack)),
        findsOneWidget);

    when(mockManageGroupController.selectedFile).thenReturn(mockPicture);

    await tester.pumpWidget(TestApp.createApp(
        body: ManageGroupPage(controller: mockManageGroupController)));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.person_outline), findsNothing);
  });

  testWidgets("Group Image uses the network image if group has imageUrl",
      (tester) async {
    Group group = Group.empty();
    group.id = "id";
    group.imageUrl = "https://example.com";
    when(mockManageGroupController.group).thenReturn(group);
    when(mockManageGroupController.selectedFile).thenReturn(null);
    await tester.pumpWidget(TestApp.createApp(
        body: ManageGroupPage(controller: mockManageGroupController)));
    await tester.pumpAndSettle();
    expect(find.byType(CircleAvatar), findsWidgets);
    expect(find.byIcon(Icons.person_outline), findsNothing);
  });

  testWidgets("Pressing edit icon opens select image bottom sheet",
      (tester) async {
    await tester.pumpWidget(TestApp.createApp(
        body: ManageGroupPage(
      controller: mockManageGroupController,
    )));
    await tester.tap(find.byIcon(Icons.edit_outlined));
    await tester.pumpAndSettle();

    expect(find.byType(BottomSheet), findsOneWidget);
    expect(find.byIcon(Icons.camera_alt), findsOneWidget);
    expect(find.text(appLocalizations.camera), findsOneWidget);
    expect(find.byIcon(Icons.image), findsOneWidget);
    expect(find.text(appLocalizations.gallery), findsOneWidget);
  });

  testWidgets("Edit fields section is correct", (tester) async {
    when(mockManageGroupController.group).thenReturn(Group.empty());
    await tester.pumpWidget(TestApp.createApp(
        body: ManageGroupPage(controller: mockManageGroupController)));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(CustomTextField, appLocalizations.groupName),
        findsOneWidget);
    expect(find.widgetWithText(CustomTextField, appLocalizations.newGroup),
        findsOneWidget);
  });

  testWidgets("Add participants section is built correctly", (tester) async {
    when(mockManageGroupController.group).thenReturn(Group.empty());
    await tester.pumpWidget(TestApp.createApp(
        body: ManageGroupPage(controller: mockManageGroupController)));
    await tester.pumpAndSettle();

    expect(find.text(appLocalizations.addParticipants), findsOneWidget);
    expect(
        find.widgetWithText(MessageCard, appLocalizations.addParticipantsTip),
        findsOneWidget);
    expect(find.widgetWithIcon(CustomOutlinedButtonIcon, Icons.add),
        findsOneWidget);
    expect(
        find.widgetWithText(
            CustomOutlinedButtonIcon, appLocalizations.addFriends),
        findsOneWidget);
  });

  testWidgets("Add Friends button shows the friends list", (tester) async {
    when(mockManageGroupController.group).thenReturn(Group.empty());
    when(mockManageGroupController.allContacts)
        .thenReturn(_generateContacts(["TestA", "TestB"]));
    await tester.pumpWidget(TestApp.createApp(
        body: ManageGroupPage(controller: mockManageGroupController)));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(CustomOutlinedButtonIcon));
    await tester.pumpAndSettle();

    expect(find.byType(BottomSheet), findsOneWidget);
    expect(find.text(appLocalizations.addParticipants), findsNWidgets(2));
    expect(find.byType(CreateGroupContactTile), findsNWidgets(2));
    expect(find.byIcon(Icons.add_circle_outline), findsNWidgets(2));
  });

  testWidgets(
      "Pressing contact icon adds it to group list and modifies icon and tip",
      (tester) async {
    Contact contact = _contactFactory("TestA");
    ManageGroupController manageGroupController =
        ManageGroupController(groupsService: MockGroupsService());
    when(mockFriendsController.allContacts).thenReturn([contact]);

    await tester.pumpWidget(TestApp.createApp(
        body: ManageGroupPage(controller: manageGroupController)));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(CustomOutlinedButtonIcon));
    await tester.pumpAndSettle();

    expect(find.byType(CreateGroupContactTile), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add_circle_outline));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.add_circle_outline), findsNothing);
    expect(
        find.ancestor(
            of: find.byIcon(Icons.delete_outline),
            matching: find.byType(BottomSheet)),
        findsOneWidget);
    expect(find.byType(CreateGroupContactTile), findsNWidgets(2));
    expect(find.byType(MessageCard), findsNothing);
    expect(manageGroupController.selectedContacts.contains(contact), true);

    await tester.tap(find.descendant(
        of: find.byType(BottomSheet),
        matching: find.byIcon(Icons.delete_outline)));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.add_circle_outline), findsOneWidget);
    expect(find.byIcon(Icons.delete_outline), findsNothing);
    expect(find.byType(MessageCard), findsOneWidget);
    expect(manageGroupController.selectedContacts.contains(contact), false);
  });

  testWidgets("Done button closes bottom sheet", (tester) async {
    Contact contact = _contactFactory("TestA");
    ManageGroupController manageGroupController =
        ManageGroupController(groupsService: MockGroupsService());
    when(mockFriendsController.allContacts).thenReturn([contact]);

    await tester.pumpWidget(TestApp.createApp(
        body: ManageGroupPage(controller: manageGroupController)));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(CustomOutlinedButtonIcon));
    await tester.pumpAndSettle();

    expect(find.byType(BottomSheet), findsOneWidget);
    expect(find.widgetWithText(CustomTextButton, appLocalizations.done),
        findsOneWidget);

    await tester.tap(find.text(appLocalizations.done));
    await tester.pumpAndSettle();

    expect(find.byType(BottomSheet), findsNothing);
    expect(find.widgetWithText(CustomTextButton, appLocalizations.done),
        findsNothing);
  });

  testWidgets("Pressing on the participant list also removes the contact",
      (tester) async {
    Contact contact = _contactFactory("TestA");
    ManageGroupController manageGroupController =
        ManageGroupController(groupsService: MockGroupsService());
    when(mockFriendsController.allContacts).thenReturn([contact]);

    await tester.pumpWidget(TestApp.createApp(
        body: ManageGroupPage(controller: manageGroupController)));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(CustomOutlinedButtonIcon));
    await tester.pumpAndSettle();

    expect(find.byType(BottomSheet), findsOneWidget);
    expect(find.widgetWithText(CustomTextButton, appLocalizations.done),
        findsOneWidget);

    await tester.tap(find.byIcon(Icons.add_circle_outline));
    await tester.pumpAndSettle();

    expect(manageGroupController.selectedContacts.contains(contact), true);

    await tester.tap(find.text(appLocalizations.done));
    await tester.pumpAndSettle();

    expect(find.byType(BottomSheet), findsNothing);
    expect(find.widgetWithText(CustomTextButton, appLocalizations.done),
        findsNothing);

    expect(find.byIcon(Icons.delete_outline), findsOneWidget);
    expect(find.byType(CreateGroupContactTile), findsOneWidget);
    expect(find.byType(MessageCard), findsNothing);

    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();

    expect(find.byType(MessageCard), findsOneWidget);
    expect(manageGroupController.selectedContacts.contains(contact), false);
  });
}

Contact _contactFactory(String contactName) {
  return Contact(
    shareLocationTo: true,
    id: "id $contactName",
    name: contactName,
    email: "Contact email",
    imageUrl: "https://example.com/image",
    phone: "123",
  );
}

List<Contact> _generateContacts(List<String> names) {
  return names.map((name) => _contactFactory(name)).toList();
}
