import 'package:flutter/material.dart';
import 'package:spike_theme_app/theme/primarycolor_switcher.dart';
import 'package:spike_theme_app/theme/theme_switcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const double _containerWidth = 450.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme & Primary Color Switcher'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 17),
          width: _containerWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text('Theme'),
              ),
              ThemeSwitcher(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text('Primary Color'),
              ),
              const PrimaryColorSwitcher(),
            ],
          ),
        ),
      ),
    );
  }
}
