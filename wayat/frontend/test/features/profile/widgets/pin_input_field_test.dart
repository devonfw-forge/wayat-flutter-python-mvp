import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/features/profile/widgets/pin_input_field.dart';
import 'package:mockito/annotations.dart';

import '../../../test_common/test_app.dart';
import 'pin_input_field_test.mocks.dart';

@GenerateMocks([UserState])
void main() async {
  setUpAll(() {
    GetIt.I.registerSingleton<UserState>(MockUserState());
  });

  testWidgets('Phone textfield widget has an input textfield', (tester) async {
    await tester.pumpWidget(TestApp.createApp(
        body: PinInputField(
      onSubmit: (_) {},
    )));
    expect(find.byType(PinInputField), findsOneWidget);
  });
}
