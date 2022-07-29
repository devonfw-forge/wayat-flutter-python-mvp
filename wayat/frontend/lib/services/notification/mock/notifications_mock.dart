import 'package:wayat/domain/notification/notification.dart';

class NotificationsMock {
  static final List<Notification> notifications = [
    Notification(
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
    Notification(
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
    Notification(
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

  static List<Notification> getAllNotificationsByUserID() {
    return notifications.where((not) => not.invitedUserID == 123).toList();
  }
}
