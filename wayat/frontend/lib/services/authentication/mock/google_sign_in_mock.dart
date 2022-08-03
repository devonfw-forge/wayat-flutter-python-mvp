import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';

class CustomMockGoogleSignIn extends MockGoogleSignIn {
  MockGoogleSignInAccount? _currentUser;

  bool _isCancelled = false;

  @override
  Future<GoogleSignInAccount?> signIn() {
    _currentUser = CustomMockGSignInAccount();
    return Future.value(_isCancelled ? null : _currentUser);
  }
}

class CustomMockGSignInAccount extends MockGoogleSignInAccount {
  @override
  Future<GoogleSignInAuthentication> get authentication =>
      Future.value(CustomMockGSignInAuthentication());
}

class CustomMockGSignInAuthentication extends MockGoogleSignInAuthentication {
  @override
  String get idToken => 
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20'
    'iLCJhenAiOiJhenAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiJhdWQuYXBwcy5nb29nbGV'
    '1c2VyY29udGVudC5jb20iLCJzdWIiOiJzdWIiLCJlbWFpbCI6Im5hbWVAZXhhbXBsZS5jb20iLCJlbWFpbF9'
    '2ZXJpZmllZCI6dHJ1ZSwibmFtZSI6Ik5hbWUgU3VybmFtZSIsInBpY3R1cmUiOiJodHRwczovL2ltYWdlcy5'
    'wZXhlbHMuY29tL3Bob3Rvcy81MzgxNTAwL3BleGVscy1waG90by01MzgxNTAwLmpwZWc_YXV0bz1jb21wcmV'
    'zcyZjcz10aW55c3JnYiZ3PTEyNjAmaD03NTAmZHByPTEiLCJnaXZlbl9uYW1lIjoiTmFtZSIsImZhbWlseV9'
    'uYW1lIjoiU3VybmFtZSIsImxvY2FsZSI6ImVzLTQxOSIsImlhdCI6MTY1OTA4MjM2MSwiZXhwIjoxOTExODk'
    'yMTQzfQ.0vPS86nFfgMA22DVmsmpS4g1ZJGQ_9nYTWfWmLTUXfQ';
}
