class InitialLocationProvider {
  InitialLocation initialLocation;
  InitialLocationProvider(this.initialLocation);
}

enum InitialLocation {
  map("/"),
  friends("/contacts/friends"),
  requests("/contacts/requests");

  const InitialLocation(this.value);
  final String value;

  factory InitialLocation.fromValue(String value) {
    return values.firstWhere((e) => e.value == value,
        orElse: () => InitialLocation.map);
  }
}
