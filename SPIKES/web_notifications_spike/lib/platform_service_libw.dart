import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

/// Service for platform detection
class PlatformService {
  // Whether is web environment
  bool get isWeb => kIsWeb;

  // Whether is mobile environment
  bool get isMobile =>
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS) &&
      !isWeb;

  bool get isDesktopOrWeb =>
      defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.linux ||
      isWeb;

  /// Gets the platform where the application is executed.
  ///
  /// Web is not included.
  TargetPlatform get targetPlatform => defaultTargetPlatform;

  /// Gets the side of the screen with the shortest distance
  /// from the device, and compares it with a magic number
  /// used to classify wide screens.
  ///
  /// For convenience, 600 is usually used for 7 inches tablets,
  /// but there are exceptions such as the *Nexus 7 2012* whose
  /// value is 552, therefore it is preferred to use 550.
  bool get wideUi =>
      MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .size
          .shortestSide >=
      550;
}
