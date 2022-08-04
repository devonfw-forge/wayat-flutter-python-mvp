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
For **ANDROID** builds there must be a *google-services.json* pasted in ```frontend/android/app``` path folder