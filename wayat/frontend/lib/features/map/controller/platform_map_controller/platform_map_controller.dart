/// Abstract class that defines the methods used by the Map Controllers.
///
/// [T] is meant to be either [GoogleMapController] or [MapController] from flutter_maps.
abstract class PlatformMapController<T> {
  void move(double latitude, double longitude);
}
