import 'package:flutter_test/flutter_test.dart';
import 'package:wayat/services/share_location/background_location_exception.dart';

void main() {
  test('Background location exception has the correct message', () {
    BackgroundLocationException exception = BackgroundLocationException();
    expect(
        exception.toString(),
        'Background Location Services Exception: '
        'The user did not allow background location services');
  });
}
