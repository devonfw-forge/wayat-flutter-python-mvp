import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/group/group.dart';
import 'dart:async';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';
import 'package:wayat/services/image_service/image_service.dart';

part 'map_controller.g.dart';

// ignore: library_private_types_in_public_api
class MapController = _MapController with _$MapController;

abstract class _MapController with Store {
  ImageService imageService;

  _MapController({ImageService? imageService})
      : imageService = imageService ?? ImageService();

  @observable
  bool sharingLocation = true;

  /// Initialize current location
  @observable
  Location currentLocation = Location();

  /// Initialize [allMarkers] of the contacts which show on the map
  Set<Marker> allMarkers = Set.of({});

  /// Initialize [filterMarkers], which show active contacts
  @observable
  ObservableSet<Marker> filteredMarkers = ObservableSet.of({});

  /// Initialize list of [contacts]
  List<ContactLocation> contacts = [];

  /// Google map controller
  late GoogleMapController gMapController;

  /// Initialize [searchBarText] text
  String searchBarText = "";

  /// Groups, which user select. Contacts of [selectedGroup] show on the map
  Group? selectedGroup;

  /// Contacts that are members of the group - [groupMembers]
  List<Contact> groupMembers = [];

  late Function(ContactLocation contact, BitmapDescriptor icon) onMarkerPressed;

  /// Set contact marker on the map
  void setOnMarkerPressed(
      Function(ContactLocation contact, BitmapDescriptor icon)
          onMarkerPressed) {
    this.onMarkerPressed = onMarkerPressed;
  }

  /// Return all generated markers
  Future getMarkers() async {
    Set<Marker> newMarkers = await generateMarkers();

    setMarkers(newMarkers);
  }

  /// Generate markers from contacts
  Future<Set<Marker>> generateMarkers() async {
    Map<String, BitmapDescriptor> bitmaps = await imageService
        .getBitmapsFromUrl(contacts.map((e) => e.imageUrl).toList());
    Set<Marker> newMarkers = contacts
        .map(
          (e) => Marker(
              markerId:
                  MarkerId("${e.id}¿?${e.name}¿?${e.longitude}${e.latitude}"),
              position: LatLng(e.latitude, e.longitude),
              icon: bitmaps[e.imageUrl] ?? BitmapDescriptor.defaultMarker,
              onTap: () => onMarkerPressed(e, bitmaps[e.imageUrl]!)),
        )
        .toSet();
    return newMarkers;
  }

  /// Set markers from [newMarkers]
  @action
  void setMarkers(Set<Marker> newMarkers) {
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
    Iterable<Marker> markers = allMarkers.where((element) => element
        .markerId.value
        .toLowerCase()
        .split("¿?")[1]
        .contains(searchBarText.toLowerCase()));
    if (groupMembers.isNotEmpty) {
      final groupMembersId = groupMembers.map((e) => e.id.toLowerCase());
      markers = markers.where((element) => groupMembersId
          .contains(element.markerId.value.toLowerCase().split("¿?")[0]));
    }

    filteredMarkers = ObservableSet.of(markers.toSet());
  }

  /// Update map camera
  void onSuggestionsTap(contact) {
    if (!PlatformService().isWeb) {
      gMapController.moveCamera(
        CameraUpdate.newLatLng(LatLng(contact.latitude, contact.longitude)));
    }
  }
}
