import 'package:wayat/domain/location/location.dart';
import 'package:wayat/services/location/location_service.dart';
import 'mock/location-mock.dart';

class LocationServiceImpl extends LocationService {
  @override
  List<Location> getAll() {
    return LocationMock.getLocation();
  }
}
