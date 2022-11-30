import 'package:flutter_test/flutter_test.dart';
import 'package:wayat/navigation/initial_route.dart';

void main() async {
  test("Initial Location Provider enum", () {
    expect(InitialLocation.map.value, "/");
    expect(InitialLocation.friends.value, "/contacts/friends");
    expect(InitialLocation.requests.value, "/contacts/requests");
  });

  test("Initial Location Provider factory", () {
    expect(InitialLocation.fromValue("/"), InitialLocation.map);
    expect(InitialLocation.fromValue("/contacts/friends"),
        InitialLocation.friends);
    expect(InitialLocation.fromValue("/contacts/requests"),
        InitialLocation.requests);
    expect(InitialLocation.fromValue("/not-existent"), InitialLocation.map);
  });

  test("Initial Location Provider constructor", () {
    InitialLocationProvider initRoute =
        InitialLocationProvider(InitialLocation.map);
    expect(initRoute.initialLocation, InitialLocation.map);
    expect(initRoute.redirected, false);
  });

  test("Initial Location Provider should redirect method", () {
    InitialLocationProvider initRoute =
        InitialLocationProvider(InitialLocation.friends);
    expect(initRoute.shouldRedirect(), true);
    expect(initRoute.shouldRedirect(), false);
  });
}
