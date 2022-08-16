class NoLocationServiceException implements Exception {
  @override
  String toString() {
    return 'The request to access location services'
        'returned false. Location services cannot be initialized';
  }
}
