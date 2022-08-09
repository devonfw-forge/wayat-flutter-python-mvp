# wayat

Section of the wayat project responsible for displaying the graphical user interface and connecting it whit the backend section. After assessing different [options](https://docs.flutter.dev/development/data-and-backend/state-mgmt/options) for state control between widgets, it was decided to use GetIt and MobX due to its 
simplicity and the benefits they offer to write less code. Additionally, for navigation and routing it has been studied several [options](https://docs.flutter.dev/development/ui/navigation) but finally was decided to use [AutoRoute](https://pub.dev/packages/auto_route) due to its potential to set navigation declaratively and avoid extra code. In the other hand, for translations it has been established internationalization in English, Spanish and French (the language is updated along with the change of language in the system in which the app is launched).

## Architecture

It has been chosen a [feature based architecture](https://medium.com/ruangguru/an-introduction-to-flutter-clean-architecture-ae00154001b0) with some changes: domains, common functionalities and widgets, internatinalization (language translations), app state and app routing have their own directories isolated from the features as shown in this example:

~~~
PROJECT
├── domain
│   ├── contact
│   │   └── contact.dart
│   └── ...
├── common
│   └── widgets
│       ├── event_card.dart
│       └── custom_textfield.dart
├── features
│   ├── create_event
│   │   ├── page
│   │   │   └── create_event_page.dart
│   │   ├── widgets
│   │   │   └── event_card.dart
│   │   └── controller
│   │       └── create_event_controller.dart
│   └── ...
├── app_state
│   └── events_state
│       ├── event_state.dart
│       ├── event_state.g.dart
│       └── event_state_impl.dart
├── services
│   ├── contact
│   │   ├── contact_service.dart
│   │   └── contact_service_impl.dart
│   └── ...
├── lang
│   ├── app_es.arb
│   ├── app_en.arb
│   └── app_fr.arb
└── navigation
    ├── app_router.dart
    └── app_router.gr.dart
~~~

## Getting Started

In order to run the wayat frontend project in debug mode, dependencies must be downloaded first:

~~~
flutter pub get
~~~

To generate AutoRouting files:

~~~
flutter pub run build_runner watch --delete-conflicting-outputs
~~~

## Considerations

An *.env* file containing the following keys must be included in the root of the repository:
* **BASE_URL**: url that will refer to the backend project
* **GOOGLE_MAPS_KEY**: valid API key to use the Google Maps API

Additionally, a file must be added with the credentials for the app in firestore and Google services, because the authentication by google and the firestore service is used. This file is called *google-services.json* and should contain ***com.capgemini.wayat*** as app name. 

For **ANDROID** builds the *google-services.json* file should be pasted in ```frontend/android/app``` path folder.
