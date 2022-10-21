import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/common/widgets/buttons/text_icon_button.dart';
import 'package:wayat/features/authentication/page/phone_verification_missing_page.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/services/google_maps_service/url_launcher_libw.dart';

import '../../test_common/test_app.dart';
import 'cannot_login_test.mocks.dart';

@GenerateNiceMocks([MockSpec<UrlLauncherLibW>()])
void main() async {
  testWidgets("The contents of the page are correct", (tester) async {
    await tester
        .pumpWidget(TestApp.createApp(body: PhoneVerificationMissingPage()));

    expect(
        find.widgetWithText(
            CustomTextIconButton, appLocalizations.downloadWayat),
        findsOneWidget);
    expect(
        find.widgetWithText(
            CustomTextIconButton, appLocalizations.goToGitHubReleases),
        findsOneWidget);
    expect(find.text(appLocalizations.cannotLoginMessage), findsOneWidget);
  });

  testWidgets(
      "Download wayat button opens the URL to directly download the apk",
      (tester) async {
    MockUrlLauncherLibW mockUrlLauncherLibW = MockUrlLauncherLibW();
    when(mockUrlLauncherLibW
            .launchUrl(Uri.parse(appLocalizations.downloadWayatUrl)))
        .thenAnswer((_) async => true);

    await tester.pumpWidget(TestApp.createApp(
        body: PhoneVerificationMissingPage(
      urlLauncher: mockUrlLauncherLibW,
    )));

    await tester.tap(find.widgetWithText(
        CustomTextIconButton, appLocalizations.downloadWayat));

    verify(mockUrlLauncherLibW
            .launchUrl(Uri.parse(appLocalizations.downloadWayatUrl)))
        .called(1);
  });

  testWidgets("Open Github releases button opens the URL to GitHub releases",
      (tester) async {
    MockUrlLauncherLibW mockUrlLauncherLibW = MockUrlLauncherLibW();
    when(mockUrlLauncherLibW
            .launchUrl(Uri.parse(appLocalizations.goToGitHubReleasesUrl)))
        .thenAnswer((_) async => true);

    await tester.pumpWidget(TestApp.createApp(
        body: PhoneVerificationMissingPage(
      urlLauncher: mockUrlLauncherLibW,
    )));

    await tester.tap(find.widgetWithText(
        CustomTextIconButton, appLocalizations.goToGitHubReleases));

    verify(mockUrlLauncherLibW
            .launchUrl(Uri.parse(appLocalizations.goToGitHubReleasesUrl)))
        .called(1);
  });
}
