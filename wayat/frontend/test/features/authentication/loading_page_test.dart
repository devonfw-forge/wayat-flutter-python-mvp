import 'package:flutter_test/flutter_test.dart';
import 'package:wayat/common/widgets/loading_widget.dart';
import 'package:wayat/features/authentication/page/loading_page.dart';

import '../../test_common/test_app.dart';

void main() {
  group('Loading page widget tests', () {
    testWidgets('Loading page has a circular progress indicator',
        (tester) async {
      await tester.pumpWidget(TestApp.createApp(body: const LoadingPage()));
      expect(find.byType(LoadingWidget), findsOneWidget);
    });
  });
}
