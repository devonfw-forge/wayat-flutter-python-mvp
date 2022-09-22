import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:wayat/features/onboarding/controller/onboarding_controller.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:wayat/services/contact/import_phones_service_impl.dart';

import 'onboarding_controller_test.mocks.dart';

@GenerateMocks([
  OnboardingController,
  ContactsAddressServiceImpl
], customMocks: [
  MockSpec<OnboardingController>(
      as: #MockOnboardingRelaxed, onMissingStub: OnMissingStub.returnDefault),
  MockSpec<ContactsAddressServiceImpl>(
      as: #MockContactsAddressServiceImplRelaxed,
      onMissingStub: OnMissingStub.returnDefault),
])
void main() {
  setUpAll(() {
    GetIt.I.registerSingleton<OnboardingController>(MockOnboardingController());
    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
  });

  test('Onboarding controller contact list returns a contact list', () {});

  // testWidgets('OnBoarding next step', (tester) async {
  //   await tester.pumpWidget(_createApp(OnBoardingPage()));
  //   await tester.tap(find.byType(CustomOutlinedButton));
  //   await tester.pumpAndSettle();
  //   verify(controller.setOnBoardingState(OnBoardingState.Current)).called(1);
  // });
}
