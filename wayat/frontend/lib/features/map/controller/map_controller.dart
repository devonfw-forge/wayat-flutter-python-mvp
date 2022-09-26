import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/group/group.dart';
import 'dart:async';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/services/image_service/image_service.dart';
import 'package:wayat/services/location/location_service_impl.dart';

part 'map_controller.g.dart';

// ignore: library_private_types_in_public_api
class MapController = _MapController with _$MapController;

abstract class _MapController with Store {
  ImageService imageService;

  _MapController({ImageService? imageService})
      : imageService = imageService ?? ImageService();

  @observable
  bool sharingLocation = true;

  @observable
  Location currentLocation = Location();

  Set<Marker> allMarkers = Set.of({});

  @observable
  ObservableSet<Marker> filteredMarkers = ObservableSet.of({});

  List<ContactLocation> contacts = [];

  late GoogleMapController gMapController;

  String searchBarText = "";
  Group? selectedGroup;

  List<Contact> groupMembers = [];

  late Function(ContactLocation contact, BitmapDescriptor icon) onMarkerPressed;

  void setOnMarkerPressed(
      Function(ContactLocation contact, BitmapDescriptor icon)
          onMarkerPressed) {
    this.onMarkerPressed = onMarkerPressed;
  }

  Future getMarkers() async {
    Set<Marker> newMarkers = await generateMarkers();

    setMarkers(newMarkers);
  }

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

  void updateMarkers() async {
    for (var contact in contacts) {
      LatLng currentPosition = LatLng(contact.latitude, contact.longitude);
      LatLng newPosition =
          LocationServiceImpl().changeContactCoordinates(currentPosition);

      Map<String, BitmapDescriptor> bitmaps = await imageService
          .getBitmapsFromUrl(contacts.map((e) => e.imageUrl).toList());
      Set<Marker> newMarkers = contacts
          .map(
            (e) => Marker(
                markerId: MarkerId(e.name),
                position: newPosition,
                icon: bitmaps[e.imageUrl]!,
                onTap: () => onMarkerPressed(e, bitmaps[e.imageUrl]!)),
          )
          .toSet();
      setMarkers(newMarkers);
    }
  }

  @action
  void setMarkers(Set<Marker> newMarkers) {
    allMarkers = ObservableSet.of(newMarkers);
    filterMarkers();
  }

  @action
  void setContacts(List<ContactLocation> newContacts) {
    if (contacts != newContacts) contacts = newContacts;
  }

  @action
  void setSharingLocation(bool newValue) {
    sharingLocation = newValue;
  }

  @action
  void setSearchBarText(String newText) {
    searchBarText = newText;
    filterMarkers();
  }

  void filterGroup(Group group) {
    if (group == selectedGroup) {
      selectedGroup = null;
      groupMembers = [];
    } else {
      selectedGroup = group;
      groupMembers = group.members;
    }
    filterMarkersByGroup();
  }

  @action
  void filterMarkersByGroup() {
    if (groupMembers.isEmpty) {
      filteredMarkers = ObservableSet.of(allMarkers);
    } else {
      final groupMembersId = groupMembers.map((e) => e.id.toLowerCase());
      filteredMarkers = ObservableSet.of(allMarkers.where((element) =>
          groupMembersId
              .contains(element.markerId.value.toLowerCase().split("¿?")[0])));
    }
  }

  @action
  void filterMarkers() {
    filteredMarkers = ObservableSet.of(allMarkers
        .where((element) => element.markerId.value
            .toLowerCase()
            .split("¿?")[1]
            .contains(searchBarText.toLowerCase()))
        .toSet());
  }

  void onSuggestionsTap(contact) {
    gMapController.moveCamera(
        CameraUpdate.newLatLng(LatLng(contact.latitude, contact.longitude)));
  }
}
