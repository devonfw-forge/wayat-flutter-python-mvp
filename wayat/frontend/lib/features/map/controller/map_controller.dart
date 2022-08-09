import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/app_state/contacts_location/contacts_location_state.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/services/image_service/image_service.dart';
import 'package:wayat/services/location/mock/contact_location_mock.dart';

part 'map_controller.g.dart';

class MapController = _MapController with _$MapController;

abstract class _MapController with Store {
  Function(ContactLocation contact, BitmapDescriptor icon) onMarkerPressed;

  _MapController({required this.onMarkerPressed});

  ImageService imageService = ImageService();

  @observable
  bool sharingLocation = true;

  @observable
  Location currentLocation = Location();

  @observable
  ObservableSet<Marker> markers = ObservableSet.of({});

  List<ContactLocation> contacts = [];

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
              markerId: MarkerId(
                  e.name + e.longitude.toString() + e.latitude.toString()),
              position: LatLng(e.latitude, e.longitude),
              icon: bitmaps[e.imageUrl]!,
              onTap: () => onMarkerPressed(e, bitmaps[e.imageUrl]!)),
        )
        .toSet();
    return newMarkers;
  }

  @action
  void setMarkers(Set<Marker> newMarkers) {
    markers = ObservableSet.of(newMarkers);
  }

  @action
  void setContacts(List<ContactLocation> newContacts) {
    if (contacts != newContacts) contacts = newContacts;
  }

  @action
  void setSharingLocation(bool newValue) {
    sharingLocation = newValue;
  }
}
