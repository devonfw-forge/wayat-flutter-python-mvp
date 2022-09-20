flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter test --coverage
flutter pub run remove_from_coverage:remove_from_coverage -f coverage/lcov.info -r '.g.dart$'
flutter pub run remove_from_coverage:remove_from_coverage -f coverage/lcov.info -r '.gr.dart$'
flutter pub run remove_from_coverage:remove_from_coverage -f coverage/lcov.info -r '\\notifications'
flutter pub run remove_from_coverage:remove_from_coverage -f coverage/lcov.info -r '\\create_event'
flutter pub run remove_from_coverage:remove_from_coverage -f coverage/lcov.info -r '\\event_detailed_view'