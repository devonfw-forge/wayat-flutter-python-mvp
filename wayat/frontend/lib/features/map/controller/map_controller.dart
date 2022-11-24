import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/group/group.dart';
import 'dart:async';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/features/map/controller/platform_map_controller/platform_map_controller.dart';
import 'package:wayat/features/map/widgets/platform_marker_widget/mobile_marker_widget.dart';
import 'package:wayat/features/map/widgets/platform_marker_widget/platform_marker_widget.dart';
import 'package:wayat/features/map/widgets/platform_marker_widget/web_desktop_marker_widget.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';
import 'package:wayat/services/image_service/image_service.dart';

part 'map_controller.g.dart';

// ignore: library_private_types_in_public_api
class MapController = _MapController with _$MapController;

abstract class _MapController with Store {
  ImageService imageService;
  final PlatformService platformService = GetIt.I.get<PlatformService>();

  _MapController({ImageService? imageService})
      : imageService = imageService ?? ImageService();

  @observable
  bool sharingLocation = true;

  /// Initialize current location
  @observable
  Location currentLocation = Location();

  /// Initialize [allMarkers] of the contacts which show on the map
  Set<PlatformMarker> allMarkers = Set.of({});

  /// Initialize [filterMarkers], which show active contacts
  @observable
  ObservableSet<PlatformMarker> filteredMarkers = ObservableSet.of({});

  /// Initialize list of [contacts]
  List<ContactLocation> contacts = [];

  /// Platform map controller.
  ///
  /// A generic controller for the diferent map's controllers
  late PlatformMapController platformMapController;

  /// Initialize [searchBarText] text
  String searchBarText = "";

  /// Groups, which user select. Contacts of [selectedGroup] show on the map
  Group? selectedGroup;

  /// Contacts that are members of the group - [groupMembers]
  List<Contact> groupMembers = [];

  late void Function(ContactLocation contact, BitmapDescriptor icon)
      onMarkerPressed;

  /// Set contact marker on the map
  void setOnMarkerPressed(
      Function(ContactLocation contact, BitmapDescriptor icon)
          onMarkerPressed) {
    this.onMarkerPressed = onMarkerPressed;
  }

  /// Return all generated markers
  Future getMarkers() async {
    Set<PlatformMarker> newMarkers = await generateMarkers();
    setMarkers(newMarkers);
  }

  /// Generate markers from contacts
  Future<Set<PlatformMarker>> generateMarkers() async {
    Map<String, BitmapDescriptor> bitmaps = await imageService
        .getBitmapsFromUrl(contacts.map((e) => e.imageUrl).toList());
    Set<PlatformMarker> newMarkers =
        contacts.map<PlatformMarker>((ContactLocation contact) {
      if (platformService.isDesktopOrWeb) {
        return WebDesktopMarker(
          contactLocation: contact,
          onTap: () => onMarkerPressed(contact, bitmaps[contact.imageUrl]!),
        );
      }
      return MobileMarker(
          contactLocation: contact,
          icon: bitmaps[contact.imageUrl] ?? BitmapDescriptor.defaultMarker,
          onTap: () => onMarkerPressed(contact, bitmaps[contact.imageUrl]!));
    }).toSet();
    return newMarkers;
  }

  /// Set markers from [newMarkers]
  @action
  void setMarkers(Set<PlatformMarker> newMarkers) {
    allMarkers = ObservableSet.of(newMarkers);
    filterMarkers();
  }

  /// Set new contacts from [newContacts]
  @action
  void setContacts(List<ContactLocation> newContacts) {
    if (contacts != newContacts) contacts = newContacts;
  }

  /// Set sharingLocation to contact
  @action
  void setSharingLocation(bool newValue) {
    sharingLocation = newValue;
  }

  /// Set searchbar text and call [filterMarkers] to filter this contact
  @action
  void setSearchBarText(String newText) {
    searchBarText = newText;
    filterMarkers();
  }

  /// Filter contacts of the group to show on the map
  void filterGroup(Group group) {
    if (group == selectedGroup) {
      selectedGroup = null;
      groupMembers = [];
    } else {
      selectedGroup = group;
      groupMembers = group.members;
    }
    filterMarkers();
  }

  /// Add filtered markers to Set, which show on the map
  @action
  void filterMarkers() {
    Iterable<PlatformMarker> markers = allMarkers.where((marker) =>
        marker.name.toLowerCase().contains(searchBarText.toLowerCase()));
    if (selectedGroup != null) {
      final groupMembersId = groupMembers.map((e) => e.id.toLowerCase());
      markers = markers
          .where((marker) => groupMembersId.contains(marker.id.toLowerCase()));
    }
    filteredMarkers = ObservableSet.of(markers.toSet());
  }

  /// Update map camera
  void onSuggestionsTap(ContactLocation contact) {
    setSearchBarText(contact.name);
    filterMarkers();
    platformMapController.move(contact.latitude, contact.longitude);
  }
}
