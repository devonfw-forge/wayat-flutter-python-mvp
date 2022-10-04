import 'package:timeago/timeago.dart' as timeago;

class AppConfigCOntroller {

  /// Loads the messages for the library [timeago] in the available languages for the app.
  ///
  /// This messages are displayed in, for example, the [ContactDialog] that appears
  /// when tapping a user in the map, and format the date in a human friendly format.
  ///
  /// For example: `2022-09-11 9:55` could translate to `five minutes ago`.
  void setTimeAgoLocales() {
    timeago.setLocaleMessages('en', timeago.EnMessages());
    timeago.setLocaleMessages('es', timeago.EsMessages());
    timeago.setLocaleMessages('fr', timeago.FrMessages());
    timeago.setLocaleMessages('de', timeago.DeMessages());
    timeago.setLocaleMessages('nl', timeago.NlMessages());
  }
  
}