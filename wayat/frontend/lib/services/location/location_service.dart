import 'package:wayat/domain/location/location.dart';
import 'package:wayat/services/service.dart';

abstract class LocationService extends Service {
  List<Location> getAll();
}
