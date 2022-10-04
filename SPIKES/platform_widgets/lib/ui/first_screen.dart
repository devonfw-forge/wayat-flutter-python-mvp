import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:platform_widgets/utils/constants.dart';
import 'dashboard.dart';

///Login screen
class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  bool _currentSwitchValue = false;
  String switchText = "Do not ";
  String _userNameEntered = "";
  String _passwordEntered = "";

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        //image logo
        getAssetImage(),

        //User name
        Padding(
          padding: const EdgeInsets.only(
              top: padding_50, left: padding_20, right: padding_20),
          child: PlatformTextField(
            keyboardType: TextInputType.text,
            onChanged: (value) => {
              _userNameEntered = value,
              if (value.isEmpty) {showAlert(username_error)}
            },
            material: (_, __) => MaterialTextFieldData(
              decoration: const InputDecoration(labelText: username),
            ),
            cupertino: (_, __) => CupertinoTextFieldData(
              placeholder: username,
            ),
          ),
        ),

        //password
        Padding(
          padding: const EdgeInsets.all(padding_20),
          child: PlatformTextField(
            keyboardType: TextInputType.text,
            onChanged: (value) => {
              _passwordEntered = value,
              if (value.isEmpty) {showAlert(password_error)}
            },
            material: (_, __) => MaterialTextFieldData(
              decoration: const InputDecoration(labelText: password),
              obscureText: true,
            ),
            cupertino: (_, __) => CupertinoTextFieldData(
              placeholder: password,
              obscureText: true,
            ),
          ),
        ),

        //Switch
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(padding_20),
              child: PlatformSwitch(
                value: _currentSwitchValue,
                onChanged: (value) {
                  setState(() {
                    _currentSwitchValue = value;
                    if (value) {
                      switchText = "Yes,";
                    } else {
                      switchText = "No, Don't";
                    }
                  });
                },
              ),
            ),
            Text(
              '$switchText remember me ',
              style: const TextStyle(color: Colors.blueGrey, fontSize: 15),
            ),
          ],
        ),

        //Button
        Padding(
            padding: const EdgeInsets.all(padding_20),
            child: PlatformElevatedButton(
              onPressed: () {
                setState(() {
                  if (_userNameEntered.isEmpty || _passwordEntered.isEmpty) {
                    showAlert(un_pw_error);
                  } else {
                    moveToNextScreen(context);
                  }
                });
              },
              child: const Text(login),
              material: (_, __) => MaterialElevatedButtonData(),
              cupertino: (_, __) => CupertinoElevatedButtonData(),
            )),
      ],
    );
  }

  ////Return image asset
  Widget getAssetImage() {
    AssetImage assetImage = const AssetImage('images/icon_iron_man.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      padding: const EdgeInsets.only(top: padding_20, bottom: padding_20 * 2),
      alignment: Alignment.center,
      child: image,
    );
  }

  ////Shows alert message with provided text
  void showAlert(String message) {
    showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        title: const Text(alert),
        content: Text(message),
        actions: <Widget>[
          PlatformDialogAction(
            child: const Text(ok),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

////Routes to next screen
void moveToNextScreen(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => DashboardScreen()),
  );
}
