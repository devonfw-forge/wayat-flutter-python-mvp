import 'package:wayat/domain/location/contact_location.dart';

/// Google and Flutter map marker widget
abstract class PlatformMarker<T> {
  final String id;

  final String name;

  PlatformMarker({
    required ContactLocation contactLocation,
    required void Function() onTap,
  }) : 
    id = contactLocation.id,
    name = contactLocation.name;

  T get();
}