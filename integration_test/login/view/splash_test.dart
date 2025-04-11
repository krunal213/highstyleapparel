import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:highstyleapparel/navigations.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../dependencies.dart';
import '../../high_street_apparel.dart';
import '../repository/datasource/sharedpref/mock_shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late GetIt getIt;
  const String userId = "12345";
  late HighStreetApparelTest highStreetApparelTest;

  setUp(() {
    getIt = initTestDependencies();
    highStreetApparelTest = HighStreetApparelTest(SplashRoute().location);
  });

  tearDown(() {
    getIt.reset();
  });

  testWidgets('When User Is Login', (tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    when(() => getIt.get<MockSharedPreferences>().getString("customerId"))
        .thenReturn(userId);

    await tester.pumpAndSettle();

    expect(highStreetApparelTest.router.state?.uri.toString(),
        const HomeRoute(customerId: userId).location);
  });

  testWidgets('When User Is Not Login', (tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    when(() => getIt.get<MockSharedPreferences>().getString("customerId"))
        .thenReturn(null);

    await tester.pumpAndSettle();

    expect(highStreetApparelTest.router.state?.uri.toString(),
        WelcomeRoute().location);
  });
}
