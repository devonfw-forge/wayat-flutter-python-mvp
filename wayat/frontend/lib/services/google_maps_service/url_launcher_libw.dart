import 'package:url_launcher/url_launcher.dart' as launcher;

class UrlLauncherLibW {
  Future<bool> canLaunchUrl(Uri url) async {
    return await launcher.canLaunchUrl(url);
  }

  Future<bool> launchUrl(Uri url) async {
    return await launcher.launchUrl(url);
  }
}
