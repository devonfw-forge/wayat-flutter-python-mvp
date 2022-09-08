import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/common/widgets/buttons/custom_text_button.dart';
import 'package:wayat/common/widgets/buttons/outlined_button.dart';
import 'package:wayat/common/widgets/message_card.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/group/group.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';
import 'package:wayat/features/contacts/widgets/contact_tile.dart';
import 'package:wayat/features/groups/controllers/manage_group_controller/manage_group_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wayat/features/groups/pages/manage_group_page.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';

import 'manage_groups_page_test.mocks.dart';

@GenerateMocks(
    [ManageGroupController, ContactsPageController, FriendsController])
void main() async {
  ManageGroupController mockManageGroupController = MockManageGroupController();
  ContactsPageController mockContactsPageController =
      MockContactsPageController();
  FriendsController mockFriendsController = MockFriendsController();

  setUpAll(() {
    when(mockContactsPageController.friendsController)
        .thenReturn(mockFriendsController);
    GetIt.I
        .registerSingleton<ContactsPageController>(mockContactsPageController);
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

  testWidgets("ManageGroups header is correct", (tester) async {
    await tester.pumpWidget(
        _createApp(ManageGroupPage(controller: mockManageGroupController)));
    await tester.pumpAndSettle();

    expect(find.widgetWithIcon(IconButton, Icons.arrow_back), findsOneWidget);
    expect(find.text(appLocalizations.newGroup), findsOneWidget);
    expect(find.widgetWithText(CustomTextButton, appLocalizations.save),
        findsOneWidget);
  });

  testWidgets("Group image is built correctly", (tester) async {
    when(mockManageGroupController.group).thenReturn(Group.empty());
    await tester.pumpWidget(
        _createApp(ManageGroupPage(controller: mockManageGroupController)));
    await tester.pumpAndSettle();

    expect(find.widgetWithIcon(IconButton, Icons.arrow_back), findsOneWidget);
    expect(find.text(appLocalizations.newGroup), findsOneWidget);
    expect(find.widgetWithText(CustomTextButton, appLocalizations.save),
        findsOneWidget);
  });

  testWidgets("Edit fields section is correct", (tester) async {
    when(mockManageGroupController.group).thenReturn(Group.empty());
    await tester.pumpWidget(
        _createApp(ManageGroupPage(controller: mockManageGroupController)));
    await tester.pumpAndSettle();

    expect(find.widgetWithIcon(CircleAvatar, Icons.person_outline),
        findsOneWidget);
    expect(
        find.widgetWithIcon(CircleAvatar, Icons.edit_outlined), findsOneWidget);
    expect(
        find.ancestor(
            of: find.widgetWithIcon(CircleAvatar, Icons.person_outline),
            matching: find.byType(Stack)),
        findsOneWidget);
    expect(
        find.ancestor(
            of: find.widgetWithIcon(CircleAvatar, Icons.edit_outlined),
            matching: find.byType(Stack)),
        findsOneWidget);

    expect(find.text(appLocalizations.groupName), findsOneWidget);
  });

  testWidgets("Add participants section is built correctly", (tester) async {
    when(mockManageGroupController.group).thenReturn(Group.empty());
    await tester.pumpWidget(
        _createApp(ManageGroupPage(controller: mockManageGroupController)));
    await tester.pumpAndSettle();

    expect(find.text(appLocalizations.addParticipants), findsNWidgets(2));
    expect(
        find.widgetWithText(MessageCard, appLocalizations.addParticipantsTip),
        findsOneWidget);
    expect(
        find.widgetWithIcon(CustomOutlinedButton, Icons.add), findsOneWidget);
    expect(
        find.widgetWithText(CustomOutlinedButton, appLocalizations.addFriends),
        findsOneWidget);
  });

  testWidgets("Add Friends button shows the friends list", (tester) async {
    when(mockManageGroupController.group).thenReturn(Group.empty());
    when(mockManageGroupController.allContacts)
        .thenReturn(_generateContacts(["TestA", "TestB"]));
    await tester.pumpWidget(
        _createApp(ManageGroupPage(controller: mockManageGroupController)));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(CustomOutlinedButton));
    await tester.pumpAndSettle();

    expect(find.byType(BottomSheet), findsOneWidget);
    expect(find.text(appLocalizations.addParticipants), findsNWidgets(2));
    expect(find.byType(ContactTile), findsNWidgets(2));
    expect(find.byIcon(Icons.add_circle_outline), findsNWidgets(2));
  });

  testWidgets(
      "Pressing contact icon should add contact to group and change contact tile icon",
      (tester) async {
    Contact contact = _contactFactory("TestA");
    ManageGroupController manageGroupController = ManageGroupController();
    when(mockFriendsController.allContacts).thenReturn([contact]);

    await tester.pumpWidget(
        _createApp(ManageGroupPage(controller: manageGroupController)));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(CustomOutlinedButton));
    await tester.pumpAndSettle();

    expect(find.byType(ContactTile), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add_circle_outline));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.add_circle_outline), findsNothing);
    expect(find.byIcon(Icons.delete_outline), findsOneWidget);
    expect(manageGroupController.group.contacts.contains(contact), true);

    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.add_circle_outline), findsOneWidget);
    expect(find.byIcon(Icons.delete_outline), findsNothing);
    expect(manageGroupController.group.contacts.contains(contact), false);
  });
}

Contact _contactFactory(String contactName) {
  return Contact(
    available: true,
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
