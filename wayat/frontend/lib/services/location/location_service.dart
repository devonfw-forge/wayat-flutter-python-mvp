import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/services/service.dart';

abstract class LocationService extends Service {
  ContactLocation getContactLocation(ContactLocation currentLocation);
}
