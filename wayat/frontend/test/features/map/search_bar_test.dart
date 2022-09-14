import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/location_state/location_state.dart';
import 'package:wayat/app_state/map_state/map_state.dart';
import 'package:wayat/app_state/user_status/user_status_state.dart';
import 'package:wayat/common/widgets/search_bar.dart';
import 'package:wayat/domain/group/group.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/features/groups/controllers/groups_controller/groups_controller.dart';
import 'package:wayat/features/map/controller/map_controller.dart';
import 'package:wayat/features/map/page/home_map_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wayat/features/map/widgets/suggestions_dialog.dart';
import 'package:wayat/features/map/widgets/suggestions_tile.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:mobx/mobx.dart' show ObservableListExtension, ObservableSet;
import 'package:wayat/services/image_service/image_service.dart';

import 'search_bar_test.mocks.dart';

@GenerateMocks([
  LocationState,
  UserStatusState,
  MapState,
  MapController,
  ImageService,
  GroupsController
], customMocks: [])
void main() async {
  late LocationState mockLocationState;
  late UserStatusState mockUserStatusState;
  late MapState mockMapState;

  setUpAll(() {
    mockLocationState = MockLocationState();
    mockUserStatusState = MockUserStatusState();
    mockMapState = MockMapState();
    final GroupsController mockGroupsController = MockGroupsController();

    GetIt.I.registerSingleton<LocationState>(mockLocationState);
    GetIt.I.registerSingleton<UserStatusState>(mockUserStatusState);
    GetIt.I.registerSingleton<MapState>(mockMapState);
    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
    GetIt.I.registerSingleton<GroupsController>(mockGroupsController);

    HttpOverrides.global = null;

    when(mockLocationState.initialize())
        .thenAnswer((realInvocation) => Future.value(null));
    when(mockLocationState.currentLocation).thenReturn(const LatLng(0, 0));
    when(mockLocationState.shareLocationEnabled).thenReturn(true);
    when(mockGroupsController.updateGroups())
        .thenAnswer((_) => Future.value(true));
    when(mockGroupsController.groups)
        .thenAnswer((_) => <Group>[].asObservable());
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

  testWidgets("The search bar appears correctly", (tester) async {
    when(mockUserStatusState.contacts).thenReturn([]);

    await tester.pumpWidget(_createApp(HomeMapPage()));
    await tester.pump();
    expect(find.byType(SearchBar), findsOneWidget);
    expect(find.widgetWithIcon(SearchBar, Icons.search), findsOneWidget);
    expect(find.widgetWithText(SearchBar, appLocalizations.search),
        findsOneWidget);
  });

  testWidgets("Get markers is called", (tester) async {
    List<ContactLocation> contacts =
        _generateLocatedContacts(["TestA", "TestB", "TestC", "TestD"]);
    when(mockUserStatusState.contacts).thenReturn(contacts);
    MapController controller = MockMapController();
    when(controller.contacts).thenReturn([]);
    when(controller.filteredMarkers).thenReturn(ObservableSet());
    when(controller.getMarkers())
        .thenAnswer((realInvocation) => Future.value(null));

    await tester.pumpWidget(_createApp(HomeMapPage(controller: controller)));
    await tester.pump();
    verify(controller.getMarkers()).called(greaterThanOrEqualTo(1));
  });

  testWidgets("Contacts correspond to markers", (tester) async {
    List<ContactLocation> contacts =
        _generateLocatedContacts(["TestA", "TestB", "TestC", "TestD"]);
    when(mockUserStatusState.contacts).thenReturn(contacts);

    ImageService imageService = _prepareMockImageService(contacts);

    MapController controller = MapController(imageService: imageService);

    await tester.pumpWidget(_createApp(HomeMapPage(controller: controller)));
    await tester.pump();
    expect(controller.contacts.length, 4);
    expect(controller.allMarkers.length, 4);
    expect(controller.filteredMarkers.length, 4);
  });

  testWidgets("Markers are filtered with the search bar", (tester) async {
    List<ContactLocation> contacts =
        _generateLocatedContacts(["TestA", "TestB", "TestC", "TestD"]);
    when(mockUserStatusState.contacts).thenReturn(contacts);

    ImageService imageService = _prepareMockImageService(contacts);

    MapController controller = MapController(imageService: imageService);

    await tester.pumpWidget(_createApp(HomeMapPage(controller: controller)));
    await tester.pump();
    expect(controller.allMarkers.length, 4);
    expect(controller.filteredMarkers.length, 4);

    await tester.enterText(find.byType(SearchBar), "A");
    expect(controller.allMarkers.length, 4);
    expect(controller.filteredMarkers.length, 1);

    await tester.enterText(find.byType(SearchBar), "B");
    expect(controller.allMarkers.length, 4);
    expect(controller.filteredMarkers.length, 1);

    await tester.enterText(find.byType(SearchBar), "test");
    expect(controller.allMarkers.length, 4);
    expect(controller.filteredMarkers.length, 4);
  });

  testWidgets("Autocomplete dialog appears", (tester) async {
    List<ContactLocation> contacts =
        _generateLocatedContacts(["TestA", "TestB", "TestC", "TestD"]);
    when(mockUserStatusState.contacts).thenReturn(contacts);

    ImageService imageService = _prepareMockImageService(contacts);

    MapController controller = MapController(imageService: imageService);

    await tester.pumpWidget(_createApp(HomeMapPage(controller: controller)));
    await tester.pump();

    await tester.enterText(find.byType(SearchBar), "test");
    await tester.pump();

    expect(find.byType(SuggestionsDialog), findsOneWidget);
  });

  testWidgets("Autocomplete dialog contains correct number of suggestions",
      (tester) async {
    List<ContactLocation> contacts = _generateLocatedContacts(
        ["TestA", "TestB", "TestC", "TestD", "TestCD"]);
    when(mockUserStatusState.contacts).thenReturn(contacts);

    ImageService imageService = _prepareMockImageService(contacts);

    MapController controller = MapController(imageService: imageService);

    await tester.pumpWidget(_createApp(HomeMapPage(controller: controller)));
    await tester.pump();

    await tester.enterText(find.byType(SearchBar), "test");
    await tester.pump();

    expect(find.byType(SuggestionsTile), findsNWidgets(5));

    await tester.enterText(find.byType(SearchBar), "a");
    await tester.pump();

    expect(find.byType(SuggestionsTile), findsOneWidget);

    await tester.enterText(find.byType(SearchBar), "c");
    await tester.pump();

    expect(find.byType(SuggestionsTile), findsNWidgets(2));
  });

  testWidgets("Suggestions are built correctly", (tester) async {
    List<ContactLocation> contacts = _generateLocatedContacts(
        ["TestA", "TestB", "TestC", "TestD", "TestCD"]);
    when(mockUserStatusState.contacts).thenReturn(contacts);

    ImageService imageService = _prepareMockImageService(contacts);

    MapController controller = MapController(imageService: imageService);

    await tester.pumpWidget(_createApp(HomeMapPage(controller: controller)));
    await tester.pump();

    await tester.enterText(find.byType(SearchBar), "a");
    await tester.pump();

    expect(
        find.descendant(
            of: find.byType(SuggestionsTile),
            matching: find.byType(CircleAvatar)),
        findsNWidgets(2));
    expect(find.widgetWithText(SuggestionsTile, "TestA"), findsOneWidget);
  });

  testWidgets("Can tap on a suggestion", (tester) async {
    ContactLocation contact = _locatedContactFactory("TestA");

    when(mockUserStatusState.contacts).thenReturn([contact]);

    MapController mockController = MockMapController();

    when(mockController.getMarkers())
        .thenAnswer((realInvocation) => Future.value(null));
    when(mockController.contacts).thenReturn([contact]);
    when(mockController.filteredMarkers).thenReturn(
        ObservableSet.of({const Marker(markerId: MarkerId("TestA"))}));

    when(mockController.onSuggestionsTap(contact))
        .thenAnswer((_) => Future.value(null));

    await tester
        .pumpWidget(_createApp(HomeMapPage(controller: mockController)));
    await tester.pump();

    await tester.enterText(find.byType(SearchBar), "a");
    await tester.pump();

    await tester.tap(find.byType(SuggestionsTile));
    verify(mockController.onSuggestionsTap(contact)).called(1);
  });
}

ImageService _prepareMockImageService(List<ContactLocation> contacts) {
  ImageService imageService = MockImageService();
  Map<String, BitmapDescriptor> imagesMap = {};
  imagesMap.addEntries(contacts
      .map((e) => MapEntry(e.imageUrl, BitmapDescriptor.defaultMarker)));
  when(imageService.getBitmapsFromUrl(contacts.map((e) => e.imageUrl).toList()))
      .thenAnswer((_) => Future.value(imagesMap));
  return imageService;
}

ContactLocation _locatedContactFactory(String contactName) {
  return ContactLocation(
      available: true,
      id: "id1",
      name: contactName,
      email: "Contact email",
      imageUrl: "https://example.com/image",
      phone: "123",
      latitude: 0.001,
      longitude: 0.001,
      address: "Address",
      lastUpdated: DateTime.now());
}

List<ContactLocation> _generateLocatedContacts(List<String> names) {
  return names.map((name) => _locatedContactFactory(name)).toList();
}
