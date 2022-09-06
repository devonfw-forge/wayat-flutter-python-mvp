import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PhoneHandlerPage extends StatelessWidget {
  const PhoneHandlerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirebasePhoneAuthHandler(
      phoneNumber: "+34600947886",
      signOutOnSuccessfulVerification: false,
      linkWithExistingUser: false,
      builder: (context, controller) {
        return const SizedBox.shrink();
      },
      onLoginSuccess: (userCredential, autoVerified) {
        debugPrint("autoVerified: $autoVerified");
        debugPrint("Login success UID: ${userCredential.user?.uid}");
      },
      onLoginFailed: (authException, stackTrace) {
        debugPrint("An error occurred: ${authException.message}");
      },
      onError: (error, stackTrace) {},
    );
  }
}
