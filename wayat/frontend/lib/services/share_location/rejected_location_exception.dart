/// This exception will be thrown in the Share Location Service if the
/// user rejects location services
class RejectedLocationException implements Exception {
  @override
  String toString() {
    return 'Rejected Location Services Exception: '
        'The user did not accept location services';
  }
}
