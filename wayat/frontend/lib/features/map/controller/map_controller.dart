import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';
import 'dart:async';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/services/image_service/image_service.dart';
import 'package:wayat/services/location/location_service_impl.dart';

part 'map_controller.g.dart';

// ignore: library_private_types_in_public_api
class MapController = _MapController with _$MapController;

abstract class _MapController with Store {
  ImageService imageService = ImageService();

  @observable
  bool sharingLocation = true;

  @observable
  Location currentLocation = Location();

  Set<Marker> allMarkers = Set.of({});

  @observable
  ObservableSet<Marker> markers = ObservableSet.of({});

  List<ContactLocation> contacts = [];

  late GoogleMapController gMapController;

  String searchBarText = "";

  late Function(ContactLocation contact, BitmapDescriptor icon) onMarkerPressed;

  Future getMarkers(
      {required Function(ContactLocation contact, BitmapDescriptor icon)
          onMarkerPressed}) async {
    this.onMarkerPressed = onMarkerPressed;
    Set<Marker> newMarkers = await generateMarkers();

    setMarkers(newMarkers);
  }

  Future<Set<Marker>> generateMarkers() async {
    Map<String, BitmapDescriptor> bitmaps = await imageService
        .getBitmapsFromUrl(contacts.map((e) => e.imageUrl).toList());

    Set<Marker> newMarkers = contacts
        .map(
          (e) => Marker(
              markerId: MarkerId(
                  e.name + e.longitude.toString() + e.latitude.toString()),
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

  @action
  void filterMarkers() {
    markers = ObservableSet.of(allMarkers
        .where((element) => element.markerId.value
            .toLowerCase()
            .contains(searchBarText.toLowerCase()))
        .toSet());
  }
}
