import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/notification_state/notification_state.dart';
import 'package:wayat/domain/notification/push_notification.dart';
import 'package:wayat/services/notification/mock/notification_service.dart';

import '../../features/notification/widgets/dynamic_dialog_test.mocks.dart';
import 'notification_state_test.mocks.dart';

@GenerateMocks([
  NotificationService,
])
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockNotificationService mockNotificationService;
  final MockNotificationState mockNotificationState = MockNotificationState();

  setUp(() {
    mockNotificationService = MockNotificationService();
    PushNotification pushNotification = PushNotification(
      title: 'Test Notification Title',
      body: 'Test Notification Body'
    );
    GetIt.I.registerSingleton<NotificationState>(mockNotificationState);
    when(mockNotificationState.notificationInfo).thenReturn(pushNotification);
    when(mockNotificationState.totalNotifications).thenReturn(0);
    when(mockNotificationState.authorizationStatus).thenReturn(false);
  });

  test("Check Notifications count, NotificationInfo and autorization status",
      () async {
    expect(mockNotificationState.totalNotifications, 0);
    expect(mockNotificationState.authorizationStatus, false);
  });
}
