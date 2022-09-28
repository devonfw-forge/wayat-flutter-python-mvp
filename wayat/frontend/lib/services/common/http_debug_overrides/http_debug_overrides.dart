import 'dart:io';

/// Override all HTTP requests made ONLY in debug mode to avoid certificate
/// problems from the Android emulator, specifically when using Google APIs.
class HttpDebugOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
