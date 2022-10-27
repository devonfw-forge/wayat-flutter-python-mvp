import 'package:flutter_test/flutter_test.dart';
import 'package:wayat/services/share_location/no_location_service_exception.dart';

void main() {
  test('No location service exception has the correct message', () {
    NoLocationServiceException exception = NoLocationServiceException();
    expect(
        exception.toString(),
        'The request to access location services'
        'returned false. Location services cannot be initialized');
  });
}
