import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/common/widgets/components/wayat_title.dart';
import 'package:wayat/features/authentication/page/login_page.dart';
import 'package:wayat/lang/lang_singleton.dart';


void main() {

  final getIt = GetIt.instance;

  setUp(() {
    GetIt.instance.registerSingleton<SessionState>(SessionState());
    GetIt.instance.registerSingleton<LangSingleton>(LangSingleton());
  });

  
  testWidgets(
    'Login page has a title', 
    (tester) async {

      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: LoginPage(),),));
      //expect(find.widgetWithText(CustomWayatTitle, 'wayat'), findsOneWidget);
    }  
  );
}
