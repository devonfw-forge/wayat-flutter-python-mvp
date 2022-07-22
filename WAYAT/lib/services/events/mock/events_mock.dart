import 'package:wayat/domain/event/event.dart';

class EventsMock {
  static final List<Event> events = [
    Event(
      eventID: 123,
      eventPhotoUrl:
          'https://docs.flutter.dev/cookbook/img-files/effects/parallax/01-mount-rushmore.jpg',
      eventDescription:
          'Cupidatat pariatur voluptate fugiat laborum. Labore exercitation ullamco irure cillum enim ipsum eiusmod velit cillum ullamco tempor velit culpa. Ipsum excepteur non dolor deserunt laboris minim proident ipsum velit ex aliquip. Eu ex amet ipsum labore eu fugiat magna. Non mollit anim Lorem et commodo aliqua velit quis amet quis ut dolore cupidatat.',
      eventName: 'Lorem Ipsum',
      eventLocation: 'EEUU',
      eventStartDate: '1/2/22',
      eventEndDate: '2/2/22',
      eventStartHour: '14:00',
      eventEndHour: '18:00',
      eventCreatedBy: 'Josué',
      eventUserID: 321,
    ),
    Event(
      eventID: 234,
      eventPhotoUrl:
          'https://docs.flutter.dev/cookbook/img-files/effects/parallax/02-singapore.jpg',
      eventDescription:
          'Cupidatat pariatur voluptate fugiat laborum. Labore exercitation ullamco irure cillum enim ipsum eiusmod velit cillum ullamco tempor velit culpa. Ipsum excepteur non dolor deserunt laboris minim proident ipsum velit ex aliquip. Eu ex amet ipsum labore eu fugiat magna. Non mollit anim Lorem et commodo aliqua velit quis amet quis ut dolore cupidatat.',
      eventName: 'Lorem Ipsum',
      eventLocation: 'Singapore',
      eventStartDate: '3/2/22',
      eventEndDate: '4/2/22',
      eventStartHour: '15:00',
      eventEndHour: '19:00',
      eventCreatedBy: 'Fabián',
      eventUserID: 432,
    ),
    Event(
      eventID: 345,
      eventPhotoUrl:
          'https://docs.flutter.dev/cookbook/img-files/effects/parallax/03-machu-picchu.jpg',
      eventDescription:
          'Cupidatat pariatur voluptate fugiat laborum. Labore exercitation ullamco irure cillum enim ipsum eiusmod velit cillum ullamco tempor velit culpa. Ipsum excepteur non dolor deserunt laboris minim proident ipsum velit ex aliquip. Eu ex amet ipsum labore eu fugiat magna. Non mollit anim Lorem et commodo aliqua velit quis amet quis ut dolore cupidatat.',
      eventName: 'Lorem Ipsum',
      eventLocation: 'Machu picchu',
      eventStartDate: '5/2/22',
      eventEndDate: '6/2/22',
      eventStartHour: '16:00',
      eventEndHour: '20:00',
      eventCreatedBy: 'Eduard',
      eventUserID: 543,
    ),
    Event(
      eventID: 456,
      eventPhotoUrl:
          'https://docs.flutter.dev/cookbook/img-files/effects/parallax/04-vitznau.jpg',
      eventDescription:
          'Cupidatat pariatur voluptate fugiat laborum. Labore exercitation ullamco irure cillum enim ipsum eiusmod velit cillum ullamco tempor velit culpa. Ipsum excepteur non dolor deserunt laboris minim proident ipsum velit ex aliquip. Eu ex amet ipsum labore eu fugiat magna. Non mollit anim Lorem et commodo aliqua velit quis amet quis ut dolore cupidatat.',
      eventName: 'Lorem Ipsum',
      eventLocation: 'Vitznau',
      eventStartDate: '7/2/22',
      eventEndDate: '8/2/22',
      eventStartHour: '17:00',
      eventEndHour: '21:00',
      eventCreatedBy: 'Airam',
      eventUserID: 654,
    ),
    Event(
      eventID: 567,
      eventPhotoUrl:
          'https://docs.flutter.dev/cookbook/img-files/effects/parallax/05-bali.jpg',
      eventDescription:
          'Cupidatat pariatur voluptate fugiat laborum. Labore exercitation ullamco irure cillum enim ipsum eiusmod velit cillum ullamco tempor velit culpa. Ipsum excepteur non dolor deserunt laboris minim proident ipsum velit ex aliquip. Eu ex amet ipsum labore eu fugiat magna. Non mollit anim Lorem et commodo aliqua velit quis amet quis ut dolore cupidatat.',
      eventName: 'Lorem Ipsum',
      eventLocation: 'Bali',
      eventStartDate: '9/2/22',
      eventEndDate: '10/2/22',
      eventStartHour: '18:00',
      eventEndHour: '22:00',
      eventCreatedBy: 'Adrián',
      eventUserID: 765,
    ),
    Event(
      eventID: 678,
      eventPhotoUrl:
          'https://docs.flutter.dev/cookbook/img-files/effects/parallax/06-mexico-city.jpg',
      eventDescription:
          'Cupidatat pariatur voluptate fugiat laborum. Labore exercitation ullamco irure cillum enim ipsum eiusmod velit cillum ullamco tempor velit culpa. Ipsum excepteur non dolor deserunt laboris minim proident ipsum velit ex aliquip. Eu ex amet ipsum labore eu fugiat magna. Non mollit anim Lorem et commodo aliqua velit quis amet quis ut dolore cupidatat.',
      eventName: 'Lorem Ipsum',
      eventLocation: 'Mexico city',
      eventStartDate: '11/2/22',
      eventEndDate: '12/2/22',
      eventStartHour: '19:00',
      eventEndHour: '23:00',
      eventCreatedBy: 'Luís',
      eventUserID: 876,
    ),
    Event(
      eventID: 789,
      eventPhotoUrl:
          'https://docs.flutter.dev/cookbook/img-files/effects/parallax/07-cairo.jpg',
      eventDescription:
          'Cupidatat pariatur voluptate fugiat laborum. Labore exercitation ullamco irure cillum enim ipsum eiusmod velit cillum ullamco tempor velit culpa. Ipsum excepteur non dolor deserunt laboris minim proident ipsum velit ex aliquip. Eu ex amet ipsum labore eu fugiat magna. Non mollit anim Lorem et commodo aliqua velit quis amet quis ut dolore cupidatat.',
      eventName: 'Lorem Ipsum',
      eventLocation: 'Cairo',
      eventStartDate: '13/2/22',
      eventEndDate: '14/2/22',
      eventStartHour: '20:00',
      eventEndHour: '00:00',
      eventCreatedBy: 'Serhi',
      eventUserID: 987,
    ),
  ];

  static List<Event> getEventsData() {
    return events.where((event) => event.eventID != 0).toList();
  }
}
