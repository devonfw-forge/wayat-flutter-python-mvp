import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/services/image_service/image_service.dart';
import 'package:wayat/services/location/mock/contact_location_mock.dart';

part 'map_controller.g.dart';

class MapController = _MapController with _$MapController;

abstract class _MapController with Store {
  ImageService imageService = ImageService();

  @observable
  Location currentLocation = Location();

  @observable
  ObservableSet<Marker> markers = ObservableSet.of({});

  List<ContactLocation> contacts = ContactLocationMock.contacts;

  @observable
  bool sharingLocation = false;

  Future getMarkers() async {
    Map<String, BitmapDescriptor> bitmaps = await imageService
        .getBitmapsFromUrl(contacts.map((e) => e.imageUrl).toList());

    Set<Marker> newMarkers = contacts
        .map(
          (e) => Marker(
              markerId: MarkerId(e.name +
                  e.longitude.toString() +
                  e.latitude.toString()),
              position: LatLng(e.latitude, e.longitude),
              infoWindow: InfoWindow(
                  title: "Marker ${e.name}",
                  snippet: "Marker ${e.email}"),
              icon: bitmaps[e.imageUrl]!),
        )
        .toSet();

    setMarkers(newMarkers);
  }

  @action
  void setMarkers(Set<Marker> newMarkers) {
    markers = ObservableSet.of(newMarkers);
  }

  @action
  void setSharingLocation(bool newValue) {
    sharingLocation = newValue;
  }
}
