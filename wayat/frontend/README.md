# wayat

Client side of the Wayat project.

## State management
After assessing different [options](https://docs.flutter.dev/development/data-and-backend/state-mgmt/options) for state control between widgets, it was decided to use:
* [MobX](https://mobx.netlify.app/getting-started/): State management library that offers separation of concerns and leaves implementation details outside of the UI
* [GetIt](https://pub.dev/packages/get_it): Dependency injection library that removes the necessity to pass every state management controller as arguments, reducing the amount of code needed and improving code quality

## Navigation
Additionally, for navigation and routing we studied several [options](https://docs.flutter.dev/development/ui/navigation) and decided to use [AutoRoute](https://pub.dev/packages/auto_route) because in our criteria it currently provides the best way to define declarative navigation. 

## Internationalization
In the other hand, for translations it has been established [internationalization](https://docs.flutter.dev/development/accessibility-and-localization/internationalization) in English, Spanish and French (the language is updated along with the change of language in the system in which the app is launched).

## Architecture

The chosen architecture is a [feature based architecture](https://medium.com/ruangguru/an-introduction-to-flutter-clean-architecture-ae00154001b0) with some changes: domains, common functionalities and widgets, internatinalization, global state management and navigation have their own directories isolated from the features as shown in this example:

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

To generate MobX stores, Routes and json serialization classes:

~~~
flutter pub run build_runner watch --delete-conflicting-outputs
~~~
Also, the command should be left running in a terminal instance located in the project folder to make development easier when modifying files that need to generate extra code

## Considerations

An *.env* file containing the following keys must be included in the root of the repository:
* **BASE_URL**: url that will refer to the backend project
* **GOOGLE_MAPS_KEY**: valid API key to use the Google Maps API

Additionally, a file must be added with the credentials for the app in firestore and Google services, because the authentication by google and the firestore service is used. This file is called *google-services.json* and should contain ***com.capgemini.wayat*** as app name. 

For **ANDROID** the *google-services.json* file should be pasted in ```frontend/android/app``` path folder.

Lastly and most importantly, in order to execute and build the flutter app it is required to set the **GOOGLE_MAPS_KEY** as an environment variable.
