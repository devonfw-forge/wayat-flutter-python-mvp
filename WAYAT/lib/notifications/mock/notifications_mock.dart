import 'package:wayat/domain/notification.dart';

class NotificationsMock {
  static final List<NotificationsModel> notifications = [
    NotificationsModel(
      notificationID: 111,
      notificationType: 'invitation',
      eventID: 123,
      eventName: '',
      eventLocation: '',
      eventStartDate: '',
      eventEndDate: '',
      eventStartHour: '',
      eventEndHour: '',
      invitedBy: '',
      invitedByID: 123,
      invitedUser: '',
      invitedUserID: 234,
    ),
    NotificationsModel(
      notificationID: 111,
      notificationType: 'starting',
      eventID: 123,
      eventName: '',
      eventLocation: '',
      eventStartDate: '',
      eventEndDate: '',
      eventStartHour: '',
      eventEndHour: '',
      invitedBy: '',
      invitedByID: 123,
      invitedUser: '',
      invitedUserID: 234,
    ),
    NotificationsModel(
      notificationID: 111,
      notificationType: 'canceled',
      eventID: 123,
      eventName: '',
      eventLocation: '',
      eventStartDate: '',
      eventEndDate: '',
      eventStartHour: '',
      eventEndHour: '',
      invitedBy: '',
      invitedByID: 123,
      invitedUser: '',
      invitedUserID: 234,
    ),
  ];

  static List<NotificationsModel> getAllNotificationsByUserID() {
    return notifications.where((not) => not.invitedUserID == 123).toList();
  }
}
