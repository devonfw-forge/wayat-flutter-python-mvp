import 'package:desktop_webview_auth/desktop_webview_auth.dart';
import 'package:desktop_webview_auth/facebook.dart';
import 'package:desktop_webview_auth/github.dart';
import 'package:desktop_webview_auth/google.dart';
import 'package:desktop_webview_auth/twitter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_dartio/google_sign_in_dartio.dart';

const _redirectUri = 'http://localhost:5000';
const _googleClientId =
    '887276025973-5t20nepvplh65ochp6pvrd5f76jidg1u.apps.googleusercontent.com';
const _twitterApiKey = 'PASTE_YOUR_TWITTER_API_KEY';
const _twitterApiSecretKey = 'PASTE_YOUR_TWITTER_API_KEY_SECRET';
const _facebookClientId = 'PASTE_YOUR_CLIENT_ID';
const _githubClientId = 'PASTE_YOUR_GITHUB_CLIENT_ID';
const _githubClientSecret = 'PASTE_YOUR_GITHUB_CLIENT_SECRET';

/// The different OAuth providers available in this app.
enum AppOAuthProvider {
  google,
  facebook,
  twitter,
  github,
}

extension Button on AppOAuthProvider {
  Buttons get button {
    switch (this) {
      case AppOAuthProvider.google:
        return Buttons.Google;
      case AppOAuthProvider.facebook:
        return Buttons.Facebook;
      case AppOAuthProvider.twitter:
        return Buttons.Twitter;
      case AppOAuthProvider.github:
        return Buttons.GitHub;
    }
  }
}

/// Provide authentication services with [FirebaseAuth].
class AuthService {
  AuthService._();
  static AuthService instance = AuthService._();

  final _auth = FirebaseAuth.instance;
  late GoogleSignIn gSignIn;

  Stream<User?> authState() {
    return _auth.authStateChanges();
  }

  Future<void> googleSignIn() async {
    String? accessToken;
    String? idToken;

    try {
      // Handle login by a third-party provider based on the platform.
      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
        case TargetPlatform.android:
          break;
        case TargetPlatform.macOS:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          {
            GoogleSignInDart.register(clientId: _googleClientId);

            // gSignIn = GoogleSignIn(
            //   clientId: _googleClientId,
            //   scopes: ['email'],
            // );
            final gSignIn = await DesktopWebviewAuth.signIn(
              GoogleSignInArgs(
                clientId: _googleClientId,
                redirectUri: _redirectUri,
                scope: 'https://www.googleapis.com/auth/userinfo.email',
              ),
            );

            idToken = await getIdToken();
            accessToken = gSignIn!.accessToken ?? '';
          }
          break;
        default:
      }

      if (accessToken != null && idToken != null) {
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          idToken: idToken,
          accessToken: accessToken,
        );

        // Once signed in, return the UserCredential
        await _auth.signInWithCredential(credential);
      } else {
        return;
      }
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> getIdToken() async {
    return await _auth.currentUser!.getIdToken(false);
  }

  Future<GoogleSignInAccount?> signInSilently() async {
    final GoogleSignInAccount? account =
        await gSignIn.signInSilently(reAuthenticate: false);
    if (account == null) return null;
    GoogleSignInAuthentication gauth = await account.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: gauth.accessToken,
      idToken: gauth.idToken,
    );
    await _auth.signInWithCredential(credential);
    if (_auth.currentUser == null) return null;
    return account;
  }

  Future<void> twitterSignIn() async {
    String? tokenSecret;
    String? accessToken;

    try {
      // Handle login by a third-party provider based on the platform.
      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
        case TargetPlatform.android:
          break;
        case TargetPlatform.macOS:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          {
            final result = await DesktopWebviewAuth.signIn(
              TwitterSignInArgs(
                apiKey: _twitterApiKey,
                apiSecretKey: _twitterApiSecretKey,
                redirectUri: _redirectUri,
              ),
            );

            tokenSecret = result?.tokenSecret;
            accessToken = result?.accessToken;
          }
          break;
        default:
      }

      if (tokenSecret != null && accessToken != null) {
        // Create a new credential
        final credential = TwitterAuthProvider.credential(
          secret: tokenSecret,
          accessToken: accessToken,
        );

        // Once signed in, return the UserCredential
        await _auth.signInWithCredential(credential);
      } else {
        return;
      }
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  Future<void> facebookSignIn() async {
    try {
      // Handle login by a third-party provider.
      final result = await DesktopWebviewAuth.signIn(
        FacebookSignInArgs(
          clientId: _facebookClientId,
          redirectUri: _redirectUri,
        ),
      );

      if (result != null) {
        // Create a new credential
        final credential = FacebookAuthProvider.credential(result.accessToken!);

        // Once signed in, return the UserCredential
        await _auth.signInWithCredential(credential);
      } else {
        return;
      }
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  Future<void> githubSignIn() async {
    try {
      // Handle login by a third-party provider.
      final result = await DesktopWebviewAuth.signIn(
        GitHubSignInArgs(
          clientId: _githubClientId,
          clientSecret: _githubClientSecret,
          redirectUri: _redirectUri,
        ),
      );

      if (result != null) {
        // Create a new credential
        final credential = GithubAuthProvider.credential(result.accessToken!);

        // Once signed in, return the UserCredential
        await _auth.signInWithCredential(credential);
      } else {
        return;
      }
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  /// Sign the Firebase user out.
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
