/// This exception will be thrown in the Share Location Service if the
/// user selects "Allow only while using app" permission instead of
/// "Allow all the time"
class BackgroundLocationException implements Exception {
  @override
  String toString() {
    return 'Background Location Services Exception: '
        'The user did not allow background location services';
  }
}
