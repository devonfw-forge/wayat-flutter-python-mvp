import 'package:wayat/domain/event/event.dart';

class EventsMock {
  static final List<Event> events = [
    Event(
      id: 123,
      photoUrl:
          'https://docs.flutter.dev/cookbook/img-files/effects/parallax/01-mount-rushmore.jpg',
      description:
          'Cupidatat pariatur voluptate fugiat laborum. Labore exercitation ullamco irure cillum enim ipsum eiusmod velit cillum ullamco tempor velit culpa. Ipsum excepteur non dolor deserunt laboris minim proident ipsum velit ex aliquip. Eu ex amet ipsum labore eu fugiat magna. Non mollit anim Lorem et commodo aliqua velit quis amet quis ut dolore cupidatat.',
      name: 'Lorem Ipsum',
      location: 'EEUU',
      startDate: '1/2/22',
      endDate: '2/2/22',
      startHour: '14:00',
      endHour: '18:00',
      createdBy: 'Josué',
      userId: 321,
    ),
    Event(
      id: 234,
      photoUrl:
          'https://docs.flutter.dev/cookbook/img-files/effects/parallax/02-singapore.jpg',
      description:
          'Cupidatat pariatur voluptate fugiat laborum. Labore exercitation ullamco irure cillum enim ipsum eiusmod velit cillum ullamco tempor velit culpa. Ipsum excepteur non dolor deserunt laboris minim proident ipsum velit ex aliquip. Eu ex amet ipsum labore eu fugiat magna. Non mollit anim Lorem et commodo aliqua velit quis amet quis ut dolore cupidatat.',
      name: 'Lorem Ipsum',
      location: 'Singapore',
      startDate: '3/2/22',
      endDate: '4/2/22',
      startHour: '15:00',
      endHour: '19:00',
      createdBy: 'Fabián',
      userId: 432,
    ),
    Event(
      id: 345,
      photoUrl:
          'https://docs.flutter.dev/cookbook/img-files/effects/parallax/03-machu-picchu.jpg',
      description:
          'Cupidatat pariatur voluptate fugiat laborum. Labore exercitation ullamco irure cillum enim ipsum eiusmod velit cillum ullamco tempor velit culpa. Ipsum excepteur non dolor deserunt laboris minim proident ipsum velit ex aliquip. Eu ex amet ipsum labore eu fugiat magna. Non mollit anim Lorem et commodo aliqua velit quis amet quis ut dolore cupidatat.',
      name: 'Lorem Ipsum',
      location: 'Machu picchu',
      startDate: '5/2/22',
      endDate: '6/2/22',
      startHour: '16:00',
      endHour: '20:00',
      createdBy: 'Eduard',
      userId: 543,
    ),
    Event(
      id: 456,
      photoUrl:
          'https://docs.flutter.dev/cookbook/img-files/effects/parallax/04-vitznau.jpg',
      description:
          'Cupidatat pariatur voluptate fugiat laborum. Labore exercitation ullamco irure cillum enim ipsum eiusmod velit cillum ullamco tempor velit culpa. Ipsum excepteur non dolor deserunt laboris minim proident ipsum velit ex aliquip. Eu ex amet ipsum labore eu fugiat magna. Non mollit anim Lorem et commodo aliqua velit quis amet quis ut dolore cupidatat.',
      name: 'Lorem Ipsum',
      location: 'Vitznau',
      startDate: '7/2/22',
      endDate: '8/2/22',
      startHour: '17:00',
      endHour: '21:00',
      createdBy: 'Airam',
      userId: 654,
    ),
    Event(
      id: 567,
      photoUrl:
          'https://docs.flutter.dev/cookbook/img-files/effects/parallax/05-bali.jpg',
      description:
          'Cupidatat pariatur voluptate fugiat laborum. Labore exercitation ullamco irure cillum enim ipsum eiusmod velit cillum ullamco tempor velit culpa. Ipsum excepteur non dolor deserunt laboris minim proident ipsum velit ex aliquip. Eu ex amet ipsum labore eu fugiat magna. Non mollit anim Lorem et commodo aliqua velit quis amet quis ut dolore cupidatat.',
      name: 'Lorem Ipsum',
      location: 'Bali',
      startDate: '9/2/22',
      endDate: '10/2/22',
      startHour: '18:00',
      endHour: '22:00',
      createdBy: 'Adrián',
      userId: 765,
    ),
    Event(
      id: 678,
      photoUrl:
          'https://docs.flutter.dev/cookbook/img-files/effects/parallax/06-mexico-city.jpg',
      description:
          'Cupidatat pariatur voluptate fugiat laborum. Labore exercitation ullamco irure cillum enim ipsum eiusmod velit cillum ullamco tempor velit culpa. Ipsum excepteur non dolor deserunt laboris minim proident ipsum velit ex aliquip. Eu ex amet ipsum labore eu fugiat magna. Non mollit anim Lorem et commodo aliqua velit quis amet quis ut dolore cupidatat.',
      name: 'Lorem Ipsum',
      location: 'Mexico city',
      startDate: '11/2/22',
      endDate: '12/2/22',
      startHour: '19:00',
      endHour: '23:00',
      createdBy: 'Luís',
      userId: 876,
    ),
    Event(
      id: 789,
      photoUrl:
          'https://docs.flutter.dev/cookbook/img-files/effects/parallax/07-cairo.jpg',
      description:
          'Cupidatat pariatur voluptate fugiat laborum. Labore exercitation ullamco irure cillum enim ipsum eiusmod velit cillum ullamco tempor velit culpa. Ipsum excepteur non dolor deserunt laboris minim proident ipsum velit ex aliquip. Eu ex amet ipsum labore eu fugiat magna. Non mollit anim Lorem et commodo aliqua velit quis amet quis ut dolore cupidatat.',
      name: 'Lorem Ipsum',
      location: 'Cairo',
      startDate: '13/2/22',
      endDate: '14/2/22',
      startHour: '20:00',
      endHour: '00:00',
      createdBy: 'Serhi',
      userId: 987,
    ),
  ];

  static List<Event> getEventsData() {
    return events.where((event) => event.id != 0).toList();
  }
}
