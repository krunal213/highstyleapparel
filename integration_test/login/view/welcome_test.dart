import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:highstyleapparel/navigations.dart';
import 'package:integration_test/integration_test.dart';
import '../../dependencies.dart';
import '../../high_street_apparel.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late GetIt getIt;
  late HighStreetApparelTest highStreetApparelTest;

  setUp(() {
    getIt = initTestDependencies();
    highStreetApparelTest = HighStreetApparelTest(WelcomeRoute().location);
  });

  tearDown(() {
    getIt.reset();
  });

  testWidgets('When Click On Login Button', (tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    await tester.tap(find.byKey(const Key('outlinebutton_widget_login')));
    await tester.pump();

    expect(highStreetApparelTest.router.state?.path, LoginRoute().location);
  });

  testWidgets('When Click On Signup Button', (tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    await tester.tap(find.byKey(const Key('outlinebutton_widget_signup')));
    await tester.pump();

    expect(highStreetApparelTest.router.state?.path, SignUpRoute().location);
  });
}
