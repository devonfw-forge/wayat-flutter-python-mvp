import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/features/authentication/common/login_title.dart';
import 'package:wayat/common/widgets/components/wayat_title.dart';
import 'package:wayat/common/widgets/phoneVerificationField/phone_verification_field.dart';
import 'package:wayat/lang/app_localizations.dart';

/// Phone validation page for login
class PhoneValidationPage extends StatelessWidget {
  final userState = GetIt.I.get<UserState>();
  PhoneValidationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          await GetIt.I.get<UserState>().logOut();
          return true;
        },
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1,
                  vertical: MediaQuery.of(context).size.height * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomWayatTitle(),
                  const CustomLoginTitle(),
                  _phoneDescription(),
                  PhoneVerificationField(),
                ],
              ),
            ),
          ),
        ));
  }

  /// Returns widget with title and description of phone number validation process
  Container _phoneDescription() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Text(
            appLocalizations.phoneNumber,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(appLocalizations.phonePageDescription,
              textAlign: TextAlign.center),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
