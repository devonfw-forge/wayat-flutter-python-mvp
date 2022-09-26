import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wayat/common/widgets/buttons/text_icon_button.dart';

void main() async {
  Widget createApp(Widget body) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: body,
        ),
      ),
    );
  }

  testWidgets("TextIconButton contains the correct elements", (tester) async {
    await tester.pumpWidget(createApp(CustomTextIconButton(
        text: "Text", icon: Icons.home, onPressed: () {})));

    expect(
        find.widgetWithIcon(CustomTextIconButton, Icons.home), findsOneWidget);
    expect(find.widgetWithText(CustomTextIconButton, "Text"), findsOneWidget);

    await tester.pumpWidget(createApp(CustomTextIconButton(
        text: "Second", icon: Icons.close, onPressed: () {})));

    expect(
        find.widgetWithIcon(CustomTextIconButton, Icons.close), findsOneWidget);
    expect(find.widgetWithText(CustomTextIconButton, "Second"), findsOneWidget);
  });

  testWidgets("TextIconButton calls the onPressed method correctly",
      (tester) async {
    int value = 0;
    increaseValue() => value++;

    await tester.pumpWidget(createApp(CustomTextIconButton(
        text: "Text", icon: Icons.home, onPressed: increaseValue)));

    expect(value, 0);

    await tester.tap(find.byType(CustomTextIconButton));
    await tester.pumpAndSettle();

    expect(value, 1);
  });
}
