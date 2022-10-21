import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/common/widgets/buttons/text_icon_button.dart';
import 'package:wayat/features/onboarding/controller/onboarding_controller.dart';
import 'package:wayat/features/onboarding/controller/onboarding_progress.dart';
import 'package:wayat/features/onboarding/widgets/initial_manage_tip.dart';
import 'package:mockito/annotations.dart';

import '../../../test_common/test_app.dart';
import 'initial_manage_tip_test.mocks.dart';

@GenerateMocks([OnboardingController])
late OnboardingController controller;

void main() async {
  setUpAll(() async {
    controller = MockOnboardingController();
    GetIt.I.registerSingleton<OnboardingController>(controller);
  });

  testWidgets('InitialManageContactsTip has a CustomTextIconButton',
      (tester) async {
    await tester
        .pumpWidget(TestApp.createApp(body: InitialManageContactsTip()));
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(CustomTextIconButton), findsOneWidget);
  });

  testWidgets(
      'Tap on CustomTextIconButton progress to importAddressBookContacts',
      (tester) async {
    await tester
        .pumpWidget(TestApp.createApp(body: InitialManageContactsTip()));
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(find.byType(CustomTextIconButton));
    await tester.pumpAndSettle();
    verify(controller.progressTo(OnBoardingProgress.importAddressBookContacts))
        .called(1);
  });
}
