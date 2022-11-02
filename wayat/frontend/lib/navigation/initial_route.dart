class InitialLocationProvider {
  InitialLocation initialLocation;
  bool redirected = false;
  InitialLocationProvider(this.initialLocation);

  bool shouldRedirect() {
    bool res = initialLocation != InitialLocation.map && !redirected;
    print("DEBUG initial location ${initialLocation.value}");
    print("DEBUG already redirected $redirected");
    print("DEBUG shouldRedirect $res");
    redirected = true;
    return res;
  }
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
