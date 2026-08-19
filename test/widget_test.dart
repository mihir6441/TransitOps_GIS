import 'package:flutter_test/flutter_test.dart';
import 'package:transitops_gis/core/constants/app_strings.dart';
import 'package:transitops_gis/presentation/app/transit_ops_app.dart';

import 'helpers/test_bootstrap.dart';

void main() {
  setUp(() async {
    await setUpTestDependencies();
  });

  tearDown(() async {
    await tearDownTestDependencies();
  });

  testWidgets('shows brand and dashboard placeholder on launch', (
    tester,
  ) async {
    await tester.pumpWidget(const TransitOpsApp());
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.appName), findsWidgets);
    expect(find.text(AppStrings.dashboard), findsWidgets);
    expect(find.text(AppStrings.foundationNotice), findsOneWidget);
  });

  testWidgets('navigates to settings from bottom navigation', (tester) async {
    await tester.pumpWidget(const TransitOpsApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.settings).last);
    await tester.pumpAndSettle();

    expect(find.text('Environment'), findsOneWidget);
    expect(find.text('NOT SET'), findsOneWidget);
  });
}
