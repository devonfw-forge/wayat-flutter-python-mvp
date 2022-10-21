import 'package:flutter_test/flutter_test.dart';
import 'package:wayat/services/share_location/rejected_location_exception.dart';

void main() {
  test('Rejected location exception has the correct message', () {
    RejectedLocationException exception = RejectedLocationException();
    expect(
        exception.toString(),
        'Rejected Location Services Exception: '
        'The user did not accept location services');
  });
}
