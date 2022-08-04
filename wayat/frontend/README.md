# wayat

TODO DESCRIPTION

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